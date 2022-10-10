local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('FugitiveSetup', { clear = true })
autocmd('FileType', {
  group = 'FugitiveSetup',
  pattern = 'fugitiveblame',
  command = [[nnoremap <buffer><silent> q :quit<CR>]],
})
