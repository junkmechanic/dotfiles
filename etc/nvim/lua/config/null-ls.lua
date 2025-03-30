local nls = require 'null-ls'

local code_actions = nls.builtins.code_actions
local diagnostics = nls.builtins.diagnostics
local formatting = nls.builtins.formatting

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

nls.setup {
  diagnostics_format = '[#{c}] #{m} (#{s})',
  sources = {
    code_actions.gitsigns,

    diagnostics.cfn_lint,
    diagnostics.hadolint,
    diagnostics.mypy.with {
      extra_args = function()
        local Path = require 'plenary.path'
        local pythonPath
        local venv_dir = Path:new(
          vim.fs.dirname(
            vim.fs.find('.git', { path = vim.fn.getcwd(), upward = true })[1]
          ),
          '.venv'
        )

        if vim.env.VIRTUAL_ENV then
          pythonPath = Path:new(vim.env.VIRTUAL_ENV):joinpath('bin', 'python')
        elseif venv_dir:joinpath('bin'):is_dir() then
          -- Although this works as expected, if the project uses mypy plugins (like
          -- pydantic.mypy), then you will have to pip install the library (pydantic here)
          -- in the python env set up by mason for mypy. That is just how mypy works.
          pythonPath = venv_dir:joinpath('bin', 'python')
        else
          pythonPath = vim.fn.exepath 'python'
        end
        return { '--python-executable', tostring(pythonPath) }
      end,
    },

    -- Cant be used until this issue is resolved
    -- https://github.com/williamboman/mason.nvim/issues/1693
    -- diagnostics.selene,

    diagnostics.sqlfluff.with {
      extra_args = { '--dialect', 'redshift', '--templater', 'jinja' },
    },
    diagnostics.vint,
    diagnostics.zsh,

    formatting.cmake_format,
    formatting.isort,
    formatting.prettier,
    formatting.shfmt,
    formatting.sqlfluff.with {
      extra_args = { '--dialect', 'redshift' },
    },
    formatting.stylua,
    formatting.terraform_fmt,
    formatting.yapf,

    require 'none-ls.formatting.beautysh',
    require 'none-ls.formatting.blue',

    require 'none-ls-shellcheck.diagnostics',
    require 'none-ls-shellcheck.code_actions',
  },
  on_attach = function(client, bufnr)
    -- If formatter is available, then autoformat the file on save
    -- To disable format-on-save temporarily, use ` :noautocmd w `
    if client.server_capabilities.documentFormattingProvider then
      local lspaugroup = augroup('LspFormatting', {})
      vim.api.nvim_clear_autocmds { group = lspaugroup, buffer = bufnr }
      autocmd('BufWritePre', {
        group = lspaugroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format {
            filter = function(_client)
              return _client.name == 'null-ls'
            end,
          }
        end,
      })
    end
  end,
}

require('mason-null-ls').setup {
  automatic_installation = true,
  ensure_installed = { 'beautysh', 'blue', 'shellcheck' },
}

augroup('DisableNull-ls', { clear = true })
autocmd({ 'BufEnter' }, {
  group = 'DisableNull-ls',
  pattern = { 'DiffviewFiles', 'DiffviewFileHistory' },
  callback = function()
    for client in vim.lsp.get_clients() do
      if client.name == 'null-ls' then
        vim.lsp.buf_detach_client(0, client.client_id)
      end
    end
  end,
})
