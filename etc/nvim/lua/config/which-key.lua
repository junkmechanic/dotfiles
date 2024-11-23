local wk = require 'which-key'

wk.setup {
  preset = 'classic',
  plugins = {
    marks = false,
    spelling = {
      enabled = true,
    },
  },
  replace = {
    key = {
      { '`', '<LocalLeader>' },
      { '<leader>', '<Leader>' },
      { '<cr>', '<CR>' },
      { '<tab>', '<Tab>' },
    },
    desc = {
      { '<[cC]md>', '' },
      { '<[cC][rR]>', '' },
    },
  },
  win = {
    wo = {
      winblend = 20,
    },
  },
  layout = {
    height = { min = 5, max = 25 },
    spacing = 5,
    align = 'center',
  },
}

wk.add {
  { '<Leader>B', desc = 'Swap Master Node with previous' },
  { '<Leader>W', desc = 'Swap Current Node with previous' },
  { '<Leader>b', desc = 'Swap Master Node with next' },
  { '<Leader>w', desc = 'Swap Current Node with next' },
  { '<LocalLeader>w', desc = 'Window Management' },
  { '<LocalLeader>z', desc = 'Horizontal Scrolling' },
  { 'gr', desc = 'Smart Rename' },
}
