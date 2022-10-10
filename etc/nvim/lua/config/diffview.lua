local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('DiffviewSetup', { clear = true })
autocmd('FileType', {
  group = 'DiffviewSetup',
  pattern = { 'DiffviewFiles', 'DiffviewFileHistory' },
  command = [[nnoremap <buffer><silent> q :DiffviewClose<CR>]],
})

require('diffview').setup {
  default_args = {
    DiffviewFileHistory = { '%' },
  },
}
