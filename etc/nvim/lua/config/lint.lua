local lint = require 'lint'

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Interpreter mypy typechecks against: active virtualenv, then `.venv` at the
-- repo root, then whatever python is on PATH.
local function python_path()
  local Path = require 'plenary.path'

  if vim.env.VIRTUAL_ENV then
    return tostring(Path:new(vim.env.VIRTUAL_ENV):joinpath('bin', 'python'))
  end

  local git = vim.fs.find('.git', { path = vim.fn.getcwd(), upward = true })[1]
  if git then
    local venv = Path:new(vim.fs.dirname(git), '.venv')
    if venv:joinpath('bin'):is_dir() then
      -- mypy plugins (pydantic.mypy and friends) must also be installed in
      -- mason's mypy env; that is just how mypy works
      return tostring(venv:joinpath('bin', 'python'))
    end
  end

  return vim.fn.exepath 'python3' or vim.fn.exepath 'python'
end

lint.linters_by_ft = {
  dockerfile = { 'hadolint' },
  json = { 'cfn_lint' },
  kotlin = { 'ktlint' },
  python = { 'mypy' },
  sh = { 'shellcheck' },
  sql = { 'sqlfluff' },
  yaml = { 'cfn_lint' },
  zsh = { 'zsh' },
}

-- Spelled out rather than appended to, so re-sourcing this file is idempotent
lint.linters.mypy.args = {
  '--show-column-numbers',
  '--show-error-end',
  '--hide-error-context',
  '--no-color-output',
  '--no-error-summary',
  '--no-pretty',
  '--python-executable',
  python_path,
}

-- No --dialect: it outranks a project's own .sqlfluff. The default lives in
-- ~/.sqlfluff instead. jinja is already sqlfluff's default templater, but pin it
-- explicitly for dbt-style projects.
--
-- The buffer arrives on stdin, so sqlfluff resolves .sqlfluff against the process
-- cwd rather than the file; point cwd at the buffer's directory and sqlfluff walks
-- up from there. nvim-lint evaluates this on every run, so it tracks the buffer.
lint.linters.sqlfluff = function()
  local linter = vim.deepcopy(require 'lint.linters.sqlfluff')
  local fname = vim.api.nvim_buf_get_name(0)

  linter.args = { 'lint', '--format=json', '--templater', 'jinja', '-' }
  linter.cwd = fname ~= '' and vim.fs.dirname(fname) or nil

  return linter
end

augroup('NvimLint', { clear = true })
autocmd({ 'BufReadPost', 'BufWritePost' }, {
  group = 'NvimLint',
  callback = function(args)
    -- Skip scratch/preview buffers: diffview and friends surface real filetypes
    -- in buffers that must not be linted
    if vim.bo[args.buf].buftype ~= '' or not vim.bo[args.buf].modifiable then
      return
    end
    lint.try_lint()
  end,
})
