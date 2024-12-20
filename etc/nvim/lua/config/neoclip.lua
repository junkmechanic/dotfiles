-- require('which-key').add {
--   { '<LocalLeader>y', '<Cmd>Telescope neoclip<CR>', desc = 'Search Clipboard' },
-- }

require('neoclip').setup {
  enable_persistent_history = true,
  continuous_sync = true,
  keys = {
    telescope = {
      i = {
        select = '<cr>',
        paste = '<c-p>',
        paste_behind = '<c-n>',
        -- macro replay
        replay = '<c-q>',
        delete = '<c-d>',
      },
    },
  },
}
