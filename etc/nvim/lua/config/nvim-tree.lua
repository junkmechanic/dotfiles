vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup {
  disable_netrw = true,
  open_on_setup = true,
  view = {
    adaptive_size = true,
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
  filters = {
    custom = {
      '__pycache__',
    },
  },
}

-- Invocation mapping
vim.keymap.set('n', '<LocalLeader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Locate the current file in the tree
vim.keymap.set('n', '<LocalLeader>m', ':NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })
