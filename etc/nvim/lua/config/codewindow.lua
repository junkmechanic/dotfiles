local codewindow = require 'codewindow'

local wk = require 'which-key'

codewindow.setup {
  window_border = 'rounded',
}

vim.api.nvim_set_hl(0, 'CodewindowBorder', { fg = '#323642' })

wk.add {
  { '<LocalLeader>m', codewindow.toggle_minimap, desc = 'Toggle Minimap' },
}
