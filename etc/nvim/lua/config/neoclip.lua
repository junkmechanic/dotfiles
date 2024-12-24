require('neoclip').setup {
  enable_persistent_history = true,
  continuous_sync = true,
  keys = {
    telescope = {
      i = {
        select = '<CR>',
        paste = '<C-p>',
        paste_behind = '<C-n>',
        -- macro replay
        replay = '<C-q>',
        delete = '<C-d>',
      },
    },
  },
}

vim.keymap.set(
  'n',
  '<LocalLeader>y',
  '<Cmd>Telescope neoclip<CR>',
  { noremap = true, silent = true, desc = 'Search Clipboard' }
)
