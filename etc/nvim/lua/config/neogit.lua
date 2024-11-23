require('which-key').add {
  { '<LocalLeader>x', '<Cmd>Neogit<CR>', desc = 'Launch Neogit' },
}

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
