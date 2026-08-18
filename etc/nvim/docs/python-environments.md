# Python environments

Every python tool in this config — the language server, the type checker, the
formatter, the debugger — needs to be told which interpreter to use. If they are
told different things, `pyright` flags an import that `mypy` resolves fine, or
`ruff` reformats to a style CI rejects. They all ask
[`lua/util/python.lua`](../lua/util/python.lua) instead, so there is one answer.

The assumed project manager is [uv](https://docs.astral.sh/uv/).

## What uv does that needs handling

- The project environment lives in `.venv` at the project root, but
  `UV_PROJECT_ENVIRONMENT` moves it, and that value may be absolute or relative
  to the project root.
- In a **workspace**, one `.venv` at the workspace root is shared by every member
  package. A member has its own `pyproject.toml` but no environment of its own,
  so a tool rooted at the member never finds one.
- `uv.lock` exists only at a workspace root. That makes it the reliable marker
  for "this is where the environment lives", and it is why it is checked before
  `pyproject.toml`.
- `uv run` exports `VIRTUAL_ENV`, so an environment chosen that way looks exactly
  like an activated one.

## The module

```lua
local python = require 'util.python'

python.root(path)          -- project root, or nil
python.venv(root)          -- virtualenv directory, or nil
python.interpreter(root)   -- path to python; always returns something
python.bin(name, root)     -- a tool from the project venv, or nil
```

**`root(path)`** walks up from `path` (defaulting to the current buffer, then the
cwd) and returns the first directory holding one of:

`uv.lock` → `pyproject.toml` → `setup.py` → `setup.cfg` → `requirements.txt` → `.git`

`uv.lock` is first so a workspace member resolves to the workspace root rather
than to itself. `.git` is last so tools still get a sensible working directory in
a repo with no packaging metadata at all.

**`venv(root)`** resolves in this order:

1. `VIRTUAL_ENV`, taken on trust — an explicit choice should not be second-guessed
   by probing the filesystem.
2. `UV_PROJECT_ENVIRONMENT`, resolved against `root` when relative.
3. `.venv`, searched **upward** from `root`, because a workspace member's own root
   has none.

Every candidate from 2 and 3 is stat'd for a real `bin/python`: a `.venv` left
behind by a removed interpreter still exists as a directory.

**`interpreter(root)`** is `venv(root)`'s python, falling back to the system one so
callers that must name an interpreter always have a path.

**`bin(name, root)`** returns a tool only if it is actually installed in the
project's venv, and `nil` otherwise, so the caller can fall back to mason's copy.
Preferring the project's copy is what makes a pinned linter behave the same in
nvim as it does in CI.

## Who uses it

| Config                                     | Use                                                               |
| ------------------------------------------ | ----------------------------------------------------------------- |
| [`lsp.lua`](../lua/config/lsp.lua)         | pyright's `root_dir`, and `python.pythonPath` via `before_init`   |
| [`lint.lua`](../lua/config/lint.lua)       | mypy's command, cwd and `--python-executable`; sqlfluff's command |
| [`conform.lua`](../lua/config/conform.lua) | `ruff_format`, `ruff_organize_imports` and `sqlfluff` commands    |
| [`dap.lua`](../lua/config/dap.lua)         | `dap_python.resolve_python`, the debuggee's interpreter           |
| [`lualine.lua`](../lua/config/lualine.lua) | the statusline venv indicator, via the buffer cache below         |

The mypy case is the one with teeth. mypy can only load plugins
(`pydantic.mypy` and friends) and stub packages that are installed alongside
_itself_, so mason's copy cannot see anything a project declares. Running the
project's own mypy — with cwd at the project root, so `[tool.mypy]` in
`pyproject.toml` applies — removes that whole class of false positives. When a
project has not pinned mypy, mason's copy still gets `--python-executable`
pointing at the project interpreter, so it at least sees the installed packages.

## The buffer cache

lualine's statusline refreshes on a **1000ms timer** plus `BufEnter`, `WinEnter`,
`BufWritePost` and `Filetype`, and the venv indicator sits in the active section —
so it runs at least once a second. Resolving there would walk the filesystem at
that rate. It reads a per-buffer memo instead:

```lua
python.buf_venv(bufnr)        -- memoized; walks once, then it is a table lookup
python.set_buf_venv(bufnr, v) -- publish an answer already resolved elsewhere
python.invalidate(bufnr)      -- drop one entry; no argument clears everything
```

The memo is filled two ways. pyright has resolved the environment by the time it
attaches, so an `LspAttach` handler in [`lsp.lua`](../lua/config/lsp.lua) publishes
it — python buffers never walk at all. Anything else falls back to `buf_venv`
resolving on first access, which is what covers a markdown or lua buffer sitting
inside a python project. A miss caches `false`, so "no virtualenv here" is
remembered too.

Entries are dropped on `BufDelete`, `BufWipeout` and `BufFilePost` (buffer numbers
get reused), on `LspDetach` for pyright, and the whole cache is cleared on
`DirChanged`, on writes to `pyproject.toml` or `uv.lock`, and on `FocusGained` —
the last of those being what catches a `uv sync` you ran in another terminal, which
nothing inside nvim signals.

The indicator names the _project_ rather than the environment directory, because uv
calls every project's environment `.venv`:

```
~/work/mesh-api/.venv       ->  󰌠 mesh-api
~/work/pipelines/.venv      ->  󰌠 pipelines
~/.pyenv/versions/pyglobal  ->  󰌠 pyglobal
no virtualenv               ->  (nothing)
```

## Deliberately not wired up

- **`vim.g.python3_host_prog`** — Neovim's own provider needs `pynvim` in a stable
  environment, not project dependencies. It stays pinned to the pyenv env.
- **`dap_python.setup(...)`** — the path given to `setup` is the interpreter that
  runs `debugpy.adapter`, which needs `debugpy` installed. That stays on the pyenv
  env; only the _debuggee_ follows the project.

## Checking what got resolved

```vim
:lua =vim.lsp.get_clients({ name = 'pyright' })[1].settings.python.pythonPath
:lua =require('lint').linters.mypy().cmd
:lua =require('util.python').buf_venv()
:ConformInfo
```

Or go straight to the source of the answer:

```vim
:lua local p = require('util.python') print(p.root(), p.venv(p.root()))
```

`vim.lsp.config` is read when a client starts, so an interpreter that appeared
after pyright attached needs `:LspRestart` before it is picked up.
