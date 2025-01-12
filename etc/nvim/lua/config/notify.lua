local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('NotifySetup', { clear = true })
autocmd('FileType', {
  group = 'NotifySetup',
  pattern = 'notify',
  command = [[nnoremap <buffer><silent> q :close<CR>]],
})

vim.notify = require 'notify'
