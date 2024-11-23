local gitsigns = require 'gitsigns'

local wk = require 'which-key'

gitsigns.setup()

wk.add {
  { '[g', '<Cmd>Gitsigns prev_hunk<CR>', desc = 'Previous Git Hunk' },
  { ']g', '<Cmd>Gitsigns next_hunk<CR>', desc = 'Next Git Hunk' },
  { 'gz', '<Cmd>Gitsigns preview_hunk<CR>', desc = 'Preview Hunk' },

  { '<LocalLeader>v', group = ' VCS Actions' },
  {
    '<LocalLeader>vB',
    function()
      gitsigns.blame_line { full = true }
    end,
    desc = 'Full Blame Line',
  },
  { '<LocalLeader>vP', gitsigns.preview_hunk_inline, desc = 'Preview Hunk Inline' },
  { '<LocalLeader>vS', gitsigns.stage_buffer, desc = 'Stage Buffer' },
  { '<LocalLeader>vb', gitsigns.blame_line, desc = 'Blame Line' },
  { '<LocalLeader>vd', gitsigns.toggle_deleted, desc = 'Toggle Deleted' },
  {
    '<LocalLeader>vl',
    gitsigns.toggle_current_line_blame,
    desc = 'Toggle Current Line Blame',
  },
  { '<LocalLeader>vp', gitsigns.preview_hunk, desc = 'Preview Hunk' },
  { '<LocalLeader>vs', gitsigns.stage_hunk, desc = 'Stage Hunk' },
  { '<LocalLeader>vu', gitsigns.undo_stage_hunk, desc = 'Undo Stage' },
}
