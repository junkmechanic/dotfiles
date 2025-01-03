local nls = require 'null-ls'

local code_actions = nls.builtins.code_actions
local diagnostics = nls.builtins.diagnostics
local formatting = nls.builtins.formatting

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

nls.setup {
  diagnostics_format = '[#{c}] #{m} (#{s})',
  sources = {
    code_actions.gitsigns,

    diagnostics.cfn_lint,
    diagnostics.hadolint,
    diagnostics.mypy,

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
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
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
}
