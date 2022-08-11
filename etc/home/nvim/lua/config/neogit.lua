local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<Leader>g', ':Neogit<CR>', opts)

require('neogit').setup {
  signs = {
    -- { CLOSED, OPENED }
    section = { '', '' },
    item = { '', '' },
  },
  integrations = {
    diffview = true,
  },
}
