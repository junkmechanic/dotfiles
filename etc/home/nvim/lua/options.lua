local set = vim.opt

set.pastetoggle = '<F2>' -- toggle paste mode to maintain indentation

set.splitbelow = true -- force all horizontal splits to go below current window
set.splitright = true -- force all vertical splits to go to the right of current window

set.mouse = 'a' -- activate mouse support in all modes

-- set.wildmenu = true -- show completion options along the command line in command mode
-- set.wildmode = "full" -- complete the next full match

set.shiftwidth = 4 -- the number of spaces inserted for each indentation
set.tabstop = 4 -- number of columns a tab counts for
set.shiftwidth = 4 -- number of spaces to use for each step of (auto)indent
set.smartindent = true -- make indenting smarter again
set.expandtab = true -- convert tabs to spaces

-- set.hlsearch = true -- highlight all matches on previous search pattern
-- set.incsearch = true -- highlight matches while typing the search pattern
set.ignorecase = true -- ignore case when searching for patterns
set.smartcase = true -- override `ignorecase` option if the search pattern contains upper case characters

set.backup = false -- dont create a backup file
set.swapfile = false -- dont create a swapfile for buffers

set.updatetime = 500 -- number of milliseconds the cursor is held for in insert mode

set.showbreak = '↪' -- display character for link continuation

set.number = true -- show the line number (for the current line if relative number is set)
set.relativenumber = true -- use relative line numbers

set.textwidth = 120 -- maximum allowed characters in a line (a line break is inserted after space is pressed)
set.wrap = false -- dont wrap text for lines extending beyond the display
set.formatoptions = vim.opt.formatoptions - { 't' } -- dont auto-wrap text beyond textwidth

set.completeopt = { 'longest', 'menuone' } -- only insert the longest common text, shop popup even for a single match

set.foldenable = false -- keep all folds open

set.termguicolors = true -- enable 24-bit RGB colors in terminal UI
set.colorcolumn = { '+1', '+2' } -- always highlight the two columns after `textwidth`
vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#323642' }) -- change the backgroud of the colorcolumn

set.shortmess:append 'sI' -- disable nvim intro

set.fillchars = { eob = ' ' } -- dont show any characters at the end of the buffer

set.grepprg = 'rg --hidden --vimgrep --smart-case --'
