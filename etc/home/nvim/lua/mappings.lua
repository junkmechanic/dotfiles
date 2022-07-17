local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = ","
vim.g.maplocalleader = "`"

-- Switch command mode trigger for easy access
map({"n", "v"}, ";", ":")
map({"n", "v"}, ":", ";")

-- Quicksave
map("n", "<C-z>", ":update<CR>")
map("v", "<C-z>", "<C-c>:update<CR>")
map("i", "<C-z>", "<C-o>:update<CR>")

-- Cancel search highlighting with ESC
map("n", "<Esc>", ":nohlsearch<Bar>:echo<CR>")

-- Make H and L more useful
map({"n", "v"}, "H", "^")
map({"n", "v"}, "L", "g_")

-- Quick exits
map("n", "<Leader>e", ":quit<CR>")
map("n", "<Leader>E", ":q!<CR>")
map("n", "<Leader>q", ":qa<CR>")
map("n", "<Leader>Q", ":qa!<CR>")

-- Move around splits using Ctrl + {h,j,k,l}
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resizing panes
map("n", "<C-Right>", ":vertical resize +1<CR>")
map("n", "<C-Left>", ":vertical resize -1<CR>")
map("n", "<C-Up>", ":resize -1<CR>")
map("n", "<C-Down>", ":resize +1<CR>")

-- Open all buffers as tabs
map("n", "<Leader>t", ":tab all<CR>")

-- Open all buffers as tabs
map("n", "<Leader>v", ":vert ba<CR>")

-- Horizontal scrolling with Alt + {h,l}
map("n", "<A-l>", "zl")
map("n", "<A-h>", "zh<C-h>")

-- Run macro in the `q` register 
map("n", "Q", "@q")

-- Stay in visual mode when indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Select the previously changed / yanked object
map("n", "gV", "`[v`]")

-- Tab navigation
map("n", "<Leader>n", "<esc>:tabprevious<CR>")
map("n", "<Leader>m", "<esc>:tabnext<CR>")

-- Swapping <c-p> with <up> in ex mode (and the companions)
vim.keymap.set("c", "<C-p>", "<Up>", { noremap = true })
vim.keymap.set("c", "<C-n>", "<Down>", { noremap = true })

-- Switch from Terminal Insert mode to Normal mode
vim.keymap.set("t", "<Esc>", "(&filetype == 'fzf') ? '<Esc>' : '<C-\\><C-n>'", { expr = true })

-- Switch tabs while in Terminal Insert mode
map("t", "<Leader>n", "<C-\\><C-n>:tabprevious<CR>")
map("t", "<Leader>m", "<C-\\><C-n>:tabnext<CR>")
