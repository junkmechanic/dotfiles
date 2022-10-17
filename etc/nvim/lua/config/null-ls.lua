local nls = require 'null-ls'

local code_actions = nls.builtins.code_actions
local diagnostics = nls.builtins.diagnostics
local formatting = nls.builtins.formatting

nls.setup {
  diagnostics_format = '[#{c}] #{m} (#{s})',
  sources = {
    code_actions.gitsigns,
    code_actions.shellcheck,

    diagnostics.cfn_lint,
    diagnostics.hadolint,
    diagnostics.pylama,
    diagnostics.shellcheck,
    diagnostics.sqlfluff.with {
      extra_args = { '--dialect', 'redshift', '--templater', 'jinja' },
    },
    diagnostics.vint,
    diagnostics.zsh,

    formatting.beautysh,
    formatting.blue,
    formatting.cmake_format,
    formatting.deno_fmt.with({
      filetypes = { "markdown" },
    }),
    formatting.isort,
    formatting.json_tool,
    formatting.sqlfluff.with {
      extra_args = { '--dialect', 'redshift' },
    },
    formatting.stylua,
    formatting.terraform_fmt,
  },
  on_attach = function(client, bufnr)
    -- If formatter is available, then autoformat the file on save
    if client.server_capabilities.documentFormattingProvider then
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
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
