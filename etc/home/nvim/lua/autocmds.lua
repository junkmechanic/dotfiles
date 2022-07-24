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
