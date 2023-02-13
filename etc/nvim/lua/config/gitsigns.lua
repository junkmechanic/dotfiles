local gitsigns = require 'gitsigns'

local wk = require 'which-key'

gitsigns.setup()

local options = {
  mode = 'n',
}

local mappings = {
  ['[g'] = { '<Cmd>Gitsigns prev_hunk<CR>', 'Previous Git Hunk' },
  [']g'] = { '<Cmd>Gitsigns next_hunk<CR>', 'Next Git Hunk' },
  ['gz'] = { '<Cmd>Gitsigns preview_hunk<CR>', 'Preview Hunk' },

  ['<LocalLeader>'] = {
    v = {
      name = ' VCS Actions',
      b = { gitsigns.blame_line, 'Blame Line' },
      d = { gitsigns.toggle_deleted, 'Toggle Deleted' },
      l = { gitsigns.toggle_current_line_blame, 'Toggle Current Line Blame' },
      p = { gitsigns.preview_hunk, 'Preview Hunk' },
      P = { gitsigns.preview_hunk_inline, 'Preview Hunk Inline' },
      s = { gitsigns.stage_hunk, 'Stage Hunk' },
      S = { gitsigns.stage_buffer, 'Stage Buffer' },
      u = { gitsigns.undo_stage_hunk, 'Undo Stage' },
      B = {
        function()
          gitsigns.blame_line { full = true }
        end,
        'Full Blame Line',
      },
    },
  },
}

wk.register(mappings, options)
