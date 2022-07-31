local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<C-p>", ":Telescope find_files<CR>", opts)
map("n", "<LocalLeader>g", ":Telescope live_grep<CR>", opts)
map("n", "<LocalLeader>s", ":Telescope grep_string<CR>", opts)

local actions = require("telescope.actions")

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
        ["<C-u>"] = false,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-p>"] = actions.results_scrolling_up,
        ["<C-n>"] = actions.results_scrolling_down,
        ["<C-b>"] = actions.preview_scrolling_up,
        ["<C-f>"] = actions.preview_scrolling_down,
      },
      n = {
        ["<C-b>"] = actions.preview_scrolling_up,
        ["<C-f>"] = actions.preview_scrolling_down,
      },
    },
  }
}
