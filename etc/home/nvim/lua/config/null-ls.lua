local nls = require 'null-ls'

local diagnostics = nls.builtins.diagnostics
local formatting = nls.builtins.formatting

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

nls.setup {
  diagnostics_format = '[#{c}] #{m} (#{s})',
  sources = {
    formatting.stylua,
    formatting.blue,
    formatting.isort,

    diagnostics.pylama,
  },
  on_attach = function(client, bufnr)
    if client.supports_method 'textDocument/formatting' then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.formatting { bufnr = bufnr }
        end,
      })
    end
  end,
}
