require('which-key').register(
  { ['<LocalLeader>x'] = { '<Cmd>Neogit<CR>', 'Launch Neogit' } },
  { mode = 'n' }
)

require('neogit').setup {
  signs = {
    -- { CLOSED, OPENED }
    section = { '', '' },
    item = { '', '' },
  },
  integrations = {
    diffview = true,
  },
}
