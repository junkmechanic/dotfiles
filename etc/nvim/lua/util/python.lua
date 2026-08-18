--- Shared resolution of a python project's root and its virtualenv.
---
--- uv is the assumed project manager: it keeps the project environment in `.venv`
--- at the project root, or wherever UV_PROJECT_ENVIRONMENT points, and in a uv
--- workspace that root is the directory holding `uv.lock` rather than a member's
--- own pyproject.toml. pyright, mypy, ruff and debugpy all need the same answer,
--- so they all come here for it.

local M = {}

--- `uv.lock` exists only at a uv workspace root, so it is tried first: a workspace
--- member has its own pyproject.toml but shares the root's environment. `.git` is
--- last so tools still get a sensible cwd in a repo with no packaging metadata.
local markers = {
  'uv.lock',
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  '.git',
}

--- Path to `name` inside a virtualenv, or nil when it is not there. Every lookup is
--- stat'd because a `.venv` left behind by a removed interpreter still exists as a
--- directory, and a venv only holds the tools that were installed into it.
---@param dir string virtualenv directory
---@param name string executable name
---@return string?
local function exe(dir, name)
  local path = vim.fs.joinpath(dir, 'bin', name)
  return vim.uv.fs_stat(path) and path or nil
end

--- Project root for `path`, or nil when nothing above it looks like a project.
---@param path string? file or directory to search upward from; defaults to the
---            current buffer, then the cwd for unnamed buffers
---@return string?
function M.root(path)
  if not path or path == '' then
    path = vim.api.nvim_buf_get_name(0)
  end
  if path == '' then
    path = vim.fn.getcwd()
  end

  for _, marker in ipairs(markers) do
    local root = vim.fs.dirname(vim.fs.find(marker, { path = path, upward = true })[1])
    if root then
      return root
    end
  end
end

--- Virtualenv directory to use for `root`, or nil when there is none.
---@param root string?
---@return string?
function M.venv(root)
  -- An activated virtualenv wins and is taken on trust: `uv run` and an activated
  -- `uv sync` environment both export VIRTUAL_ENV, and an explicit choice should
  -- not be second-guessed by probing the filesystem.
  if vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV ~= '' then
    return vim.env.VIRTUAL_ENV
  end

  if not root then
    return nil
  end

  -- uv honours UV_PROJECT_ENVIRONMENT over `.venv`; the value is either absolute or
  -- relative to the project root.
  local override = vim.env.UV_PROJECT_ENVIRONMENT
  if override and override ~= '' then
    local dir = vim.fs.normalize(override)
    if not vim.startswith(dir, '/') then
      dir = vim.fs.joinpath(root, dir)
    end
    if exe(dir, 'python') then
      return dir
    end
  end

  -- Searched upward rather than only in root: a uv workspace keeps one `.venv` at
  -- the workspace root, so a member package's own root has none.
  local found = vim.fs.find('.venv', {
    path = root,
    upward = true,
    type = 'directory',
    limit = math.huge,
  })
  for _, dir in ipairs(found) do
    if exe(dir, 'python') then
      return dir
    end
  end
end

--- Interpreter to typecheck and run against. Always a path, falling back to the
--- system python so callers that must name an interpreter always have one.
---@param root string?
---@return string
function M.interpreter(root)
  local venv = M.venv(root)
  if venv then
    return vim.fs.joinpath(venv, 'bin', 'python')
  end

  local system = vim.fn.exepath 'python3'
  return system ~= '' and system or vim.fn.exepath 'python'
end

--- A tool installed into the project's own virtualenv, or nil to leave the caller
--- on whatever mason put on $PATH. Preferring the project's copy is what makes a
--- pinned linter behave the same in nvim as it does in CI, and it is the only way
--- mypy sees the project's own dependencies and plugins.
---@param name string
---@param root string?
---@return string?
function M.bin(name, root)
  local venv = M.venv(root)
  return venv and exe(venv, name) or nil
end

--- Per-buffer memo of the resolved virtualenv, for callers on a hot path. The
--- statusline redraws on a one second timer, and resolving walks the filesystem, so
--- the answer has to be looked up rather than recomputed. A miss stores `false`
--- rather than nil so that "there is no virtualenv here" is cached too -- otherwise
--- every redraw in a project without one walks the tree again.
---@type table<integer, string|false>
local cache = {}

--- Publish an already-resolved virtualenv for a buffer, skipping the walk. Used by
--- the LSP, which has resolved the environment by the time it attaches.
---@param bufnr integer
---@param venv string?
function M.set_buf_venv(bufnr, venv)
  cache[bufnr] = venv or false
end

--- Forget what was resolved for a buffer, or for every buffer when called with no
--- argument. The next lookup resolves again.
---@param bufnr integer?
function M.invalidate(bufnr)
  if bufnr then
    cache[bufnr] = nil
  else
    cache = {}
  end
end

--- Virtualenv for a buffer, resolved once and remembered. Falls back to walking the
--- tree for buffers nothing has published an answer for.
---@param bufnr integer? defaults to the current buffer
---@return string?
function M.buf_venv(bufnr)
  if not bufnr or bufnr == 0 then
    bufnr = vim.api.nvim_get_current_buf()
  end

  local hit = cache[bufnr]
  if hit == nil then
    hit = M.venv(M.root(vim.api.nvim_buf_get_name(bufnr))) or false
    cache[bufnr] = hit
  end

  return hit or nil
end

vim.api.nvim_create_augroup('PythonEnvCache', { clear = true })

-- Buffer numbers are reused, so a dead buffer's answer has to go with it.
vim.api.nvim_create_autocmd({ 'BufDelete', 'BufWipeout', 'BufFilePost' }, {
  group = 'PythonEnvCache',
  callback = function(args)
    M.invalidate(args.buf)
  end,
})

-- Writing either of these can move the project root or the environment, and it can
-- do so for buffers other than the one being written, so drop everything.
-- FocusGained is the catch-all: creating a virtualenv with `uv sync` in another
-- terminal is the one staleness case nothing inside nvim signals.
vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'PythonEnvCache',
  pattern = { 'pyproject.toml', 'uv.lock' },
  callback = function()
    M.invalidate()
  end,
})
vim.api.nvim_create_autocmd({ 'DirChanged', 'FocusGained' }, {
  group = 'PythonEnvCache',
  callback = function()
    M.invalidate()
  end,
})

return M
