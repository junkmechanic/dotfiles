local hop = require 'hop'

hop.setup()

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

map({ 'n', 'v' }, '<Leader>s', function() hop.hint_char2() end, 'Hop with 2 chars')
map({ 'n', 'v' },
  '<LocalLeader>j',
  function()
    hop.hint_lines_skip_whitespace()
  end,
  'Hop to line start'
)
map({ 'n', 'v' }, '<LocalLeader>k', function() hop.hint_vertical() end, 'Hop vertically')
map({ 'n', 'v' }, '<LocalLeader>/', function() hop.hint_patterns() end, 'Hop to pattern')
