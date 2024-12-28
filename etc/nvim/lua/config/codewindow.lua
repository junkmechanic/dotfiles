local codewindow = require 'codewindow'

codewindow.setup {
  window_border = 'rounded',
}

vim.api.nvim_set_hl(0, 'CodewindowBorder', { fg = '#323642' })

vim.keymap.set(
  'n',
  '<LocalLeader>m',
  codewindow.toggle_minimap,
  { noremap = true, silent = true, desc = 'Toggle Minimap' }
)
