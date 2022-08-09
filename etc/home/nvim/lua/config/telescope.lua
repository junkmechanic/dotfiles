local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- map("n", "<C-p>", ":Telescope find_files<CR>", opts)
map("n", "<C-p>", "<Cmd>lua require'config.telescope-ext'.project_files()<CR>", opts)
map("n", "<C-n>", ":Telescope frecency<CR>", opts)
map("n", "<Leader>r", ":Telescope lsp_references<CR>", opts)
map("n", "<LocalLeader>g", ":Telescope live_grep<CR>", opts)
map("n", "<LocalLeader>s", ":Telescope grep_string<CR>", opts)
map("n", "<LocalLeader>r", ":Telescope resume<CR>", opts)
map("n", "<LocalLeader>f", ":Telescope current_buffer_fuzzy_find<CR>", opts)
map("n", "<LocalLeader>h", ":Telescope help_tags<CR>", opts)
map("n", "<LocalLeader>dd", ":Telescope diagnostics<CR>", opts)

local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-b>"] = actions.results_scrolling_up,
        ["<C-f>"] = actions.results_scrolling_down,
        ["<C-p>"] = actions.preview_scrolling_up,
        ["<C-n>"] = actions.preview_scrolling_down,
        ["<C-u>"] = false,
      },
    },
    winblend = 10,
    dynamic_preview_title = true,
  },
  pickers = {
    git_files = {
      show_untracked = true,
    },
    current_buffer_fuzzy_find = {
      skip_empty_lines = true,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    frecency = {
      ignore_patterns = { "*.git/*", "*/tmp/*", "*pycache*" },
      workspaces = {
        ["conf"] = "/Users/ankur/.config",
        ["df"] = "/Users/ankur/.files",
      },
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("frecency")
require("telescope").load_extension("neoclip")
