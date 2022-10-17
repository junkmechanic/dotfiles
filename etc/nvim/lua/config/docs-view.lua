local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('DocsViewSetup', { clear = true })
autocmd('FileType', {
  group = 'DocsViewSetup',
  pattern = 'nvim-docs-view',
  command = [[nnoremap <buffer><silent> q :DocsViewToggle<CR>]],
})

require('docs-view').setup {
  position = 'bottom',
  height = 10,
}
