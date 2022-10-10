require('gitsigns').setup()

local wk = require 'which-key'

local options = {
  mode = 'n',
}

local mappings = {
  ['[g'] = { '<Cmd>Gitsigns prev_hunk<CR>', 'Previous Git Hunk' },
  [']g'] = { '<Cmd>Gitsigns next_hunk<CR>', 'Next Git Hunk' },
}

wk.register(mappings, options)
