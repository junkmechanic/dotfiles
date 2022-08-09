local map = vim.keymap.set

map('n', '<Leader>s', '<Cmd>HopChar2<CR>', {})
map('v', '<Leader>s', '<Cmd>HopChar2<CR>', {})
map('n', '<LocalLeader>j', '<Cmd>HopLineStart<CR>', {})
map('v', '<LocalLeader>j', '<Cmd>HopLineStart<CR>', {})
map('n', '<LocalLeader>k', '<Cmd>HopVertical<CR>', {})
map('v', '<LocalLeader>k', '<Cmd>HopVertical<CR>', {})
map('n', '<LocalLeader>/', '<Cmd>HopPattern<CR>', {})
map('v', '<LocalLeader>/', '<Cmd>HopPattern<CR>', {})

require('hop').setup()
