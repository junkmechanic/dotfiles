require('mason').setup {
  ui = {
    border = 'single',
  },
}

require('mason-tool-installer').setup {
  ensure_installed = {
    -- Install packages not supported by `mason-null-ls` yet
    'deno',
  },
}

require('mason-nvim-dap').setup {
  ensure_installed = { 'bash' },
}
