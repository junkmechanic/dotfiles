local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
  end
})

--- Remove all trailing whitespace on save
augroup("TrimWhiteSpaceGrp", { clear = true })
autocmd("BufWritePre", {
  group = 'TrimWhiteSpaceGrp',
  command = [[:%s/\s\+$//e]],
})

-- Place the cursor at the same position where it was at before the previous exit
autocmd(
  "BufReadPost",
  { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- Open help in a vertical split
autocmd("FileType", {
  pattern = "help",
  command = [[wincmd L]]
})

-- windows to close with "q"
augroup("QuickFixSetup", { clear = true })
autocmd("FileType", {
  group = "QuickFixSetup",
  pattern = { "help", "startuptime", "qf", "lspinfo", "fugitive", "null-ls-info" },
  command = [[nnoremap <buffer><silent> q :close<CR>]],
})
autocmd("FileType", {
  group = "QuickFixSetup",
  pattern = "man",
  command = [[nnoremap <buffer><silent> q :quit<CR>]]
})
autocmd("FileType", {
  group = "QuickFixSetup",
  pattern = "qf",
  command = [[set switchbuf+=usetab,newtab]],
})

-- Terminal buffer settings
augroup("TerminalBufferSetup", { clear = true })
autocmd('BufEnter', {
  group = "TerminalBufferSetup",
  command = [[if &buftype == 'terminal' | :startinsert | endif]]
})
autocmd('TermOpen', {
  group = "TerminalBufferSetup",
  command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})

-- Enable spell checking for certain file types
autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.txt", "*.md", "*.tex" }, command = "setlocal spell" }
)

-- Set indentation to 2 spaces
augroup('IndentText', { clear = true })
autocmd('Filetype', {
  group = 'IndentText',
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
    'yaml', 'lua'
  },
  command = 'setlocal shiftwidth=2 tabstop=2'
})
