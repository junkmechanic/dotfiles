require('gitsigns').setup()

local options = {
  mode = 'n',
}

local mappings = {
  ['[g'] = { vim.diagnostic.goto_prev, 'Previous LSP Diagnostics Hunk' },
  [']g'] = { vim.diagnostic.goto_next, 'Next LSP Diagnostics Hunk' },
}

wk.register(mappings, options)
