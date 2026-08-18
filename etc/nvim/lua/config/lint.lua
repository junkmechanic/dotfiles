local lint = require 'lint'
local python = require 'util.python'

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

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

-- Args are spelled out rather than appended to, so re-sourcing this file is
-- idempotent. nvim-lint evaluates this on every run, so it tracks the buffer.
--
-- Preferring the project's own mypy over mason's is what makes plugins declared in
-- pyproject.toml (pydantic.mypy and friends) and the project's stub packages
-- resolve at all -- installing them into mason's mypy env is the only alternative,
-- because that is how mypy works. When only mason's copy is available
-- --python-executable at least points it at the project's interpreter, so it sees
-- the project's installed packages even though it cannot load its plugins.
--
-- cwd is the project root so mypy reads the project's own [tool.mypy] config; the
-- buffer's absolute path is appended by nvim-lint, so the cwd change is safe.
lint.linters.mypy = function()
  local linter = vim.deepcopy(require 'lint.linters.mypy')
  local root = python.root()

  linter.cmd = python.bin('mypy', root) or 'mypy'
  linter.cwd = root
  linter.args = {
    '--show-column-numbers',
    '--show-error-end',
    '--hide-error-context',
    '--no-color-output',
    '--no-error-summary',
    '--no-pretty',
    '--python-executable',
    python.interpreter(root),
  }

  return linter
end

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

  -- dbt projects pin sqlfluff and its dbt templater in the project venv; mason's
  -- copy has neither, so use the project's whenever it is there.
  linter.cmd = python.bin('sqlfluff', python.root(fname)) or 'sqlfluff'
  linter.args = { 'lint', '--format=json', '--templater', 'jinja', '-' }
  linter.cwd = fname ~= '' and vim.fs.dirname(fname) or nil

  return linter
end

-- cfn-lint validates a buffer against the CloudFormation schema unconditionally, so
-- every json and yaml file that is not a template gets reported as a broken one --
-- "'Resources' is a required property", then "Additional properties are not allowed"
-- for each of its actual keys. It is registered for whole filetypes because there is
-- no cloudformation filetype to register for, so the buffer has to be sniffed here.
local function is_cloudformation(buf)
  for _, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
    -- A top-level Resources key is what cfn-lint requires; the other two are the
    -- optional headers, matched anywhere so a template still counts while its
    -- Resources block is being written.
    if
      line:match '^Resources:'
      or line:match '^%s*"Resources"%s*:'
      or line:find 'AWSTemplateFormatVersion'
      or line:find 'AWS::Serverless'
    then
      return true
    end
  end
  return false
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
    lint.try_lint(nil, {
      filter = function(linter)
        return linter.name ~= 'cfn_lint' or is_cloudformation(args.buf)
      end,
    })
  end,
})
