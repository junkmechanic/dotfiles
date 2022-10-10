-- NvimTree startup
require('nvim-tree').setup {
  disable_netrw = true,
  view = {
    mappings = {
      list = {
        -- Convenience mappings
        { key = 's', action = 'split' },
        { key = 'v', action = 'vsplit' },
        { key = 't', action = 'tabnew' },
        -- This is to match with telescppe-file-browser mapping
        { key = '<M-c>', action = 'create' },
      },
    },
  },

  -- TODO : ignore __pycache__
}

-- Invocation mapping
vim.keymap.set('n', '<LocalLeader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Locate the current file in the tree
vim.keymap.set('n', '<LocalLeader>m', ':NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })
