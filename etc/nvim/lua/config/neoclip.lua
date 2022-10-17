require('which-key').register(
  { ['<LocalLeader>y'] = { '<Cmd>Telescope neoclip<CR>', 'Search Clipboard' } },
  { mode = 'n' }
)

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
