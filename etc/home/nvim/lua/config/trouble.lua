local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<LocalLeader>dq', '<Cmd>Trouble document_diagnostics<CR>', opts)
vim.keymap.set('n', '<LocalLeader>t', '<Cmd>Trouble workspace_diagnostics<CR>', opts)

require('trouble').setup {}
