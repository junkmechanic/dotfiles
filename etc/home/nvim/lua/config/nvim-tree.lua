-- NvimTree startup
require("nvim-tree").setup({
  disable_netrw = true,
  open_on_tab = true,

  -- TODO : ignore __pycache__
})

-- Invocation mapping
vim.keymap.set("n", "<LocalLeader>n", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Locate the current file in the tree
vim.keymap.set("n", "<LocalLeader>m", ":NvimTreeFindFileToggle<CR>", { noremap = true, silent = true })
