local gitsigns = require 'gitsigns'

gitsigns.setup()

-- Mappings

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map('n', '[g', function() gitsigns.nav_hunk('prev') end, 'Previous Git Hunk')
map('n', ']g', function() gitsigns.nav_hunk('next') end, 'Next Git Hunk')
map('n', 'gz', gitsigns.preview_hunk, 'Preview Hunk')

map(
  'n',
  '<LocalLeader>vB',
  function()
    gitsigns.blame_line { full = true }
  end,
  'Full Blame Line'
)
map('n', '<LocalLeader>vP', gitsigns.preview_hunk_inline, 'Preview Hunk Inline')
map('n', '<LocalLeader>vS', gitsigns.stage_buffer, 'Stage Buffer')
map('n', '<LocalLeader>vb', gitsigns.blame_line, 'Blame Line')
map('n', '<LocalLeader>vd', gitsigns.toggle_deleted, 'Inline Diff')
map(
  'n',
  '<LocalLeader>vl',
  gitsigns.toggle_current_line_blame,
  'Toggle Current Line Blame'
)
map('n', '<LocalLeader>vp', gitsigns.preview_hunk, 'Preview Hunk')
map('n', '<LocalLeader>vs', gitsigns.stage_hunk, 'Stage Hunk')
map('n', '<LocalLeader>vu', gitsigns.undo_stage_hunk, 'Undo Stage')
