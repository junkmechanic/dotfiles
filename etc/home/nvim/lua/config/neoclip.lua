local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<Leader>y", ":Telescope neoclip<CR>", opts)

require('neoclip').setup({
  enable_persistent_history = true,
  continuous_sync = true,
  keys = {
    telescope = {
      i = {
        select = '<cr>',
        paste = '<c-p>',
        paste_behind = '<c-n>',
        -- macro replay
        replay = '<c-q>',
        delete = '<c-d>',
      },
    },
  },
})
