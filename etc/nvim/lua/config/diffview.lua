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

-- Mappings

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map('n', '<LocalLeader>x', '<Cmd>DiffviewOpen<CR>', 'Diffview')
map(
  'n',
  '<LocalLeader>X',
  '<Cmd>DiffviewFileHistory %<CR>',
  'Diffview Current File'
)
