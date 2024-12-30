require('oil').setup {
  default_file_explorer = false,
  keymaps = {
    ['<C-s>'] = { 'actions.select', opts = { horizontal = true } },
    ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
    ['<C-h>'] = false,
    ['<C-p>'] = false,
  },
  float = {
    win_options = {
      colorcolumn = '',
    },
  },
}

vim.keymap.set(
  'n',
  '-',
  require('oil').toggle_float,
  { noremap = true, silent = true, desc = 'Open Oil' }
)
