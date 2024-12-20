local devicons = require 'nvim-web-devicons'

  -- { '<Leader>B', desc = 'Swap Master Node with previous' },
  -- { '<Leader>W', desc = 'Swap Current Node with previous' },
  -- { '<Leader>b', desc = 'Swap Master Node with next' },
  -- { '<Leader>w', desc = 'Swap Current Node with next' },
  -- { '<LocalLeader>w', desc = 'Window Management' },
  -- { '<LocalLeader>z', desc = 'Horizontal Scrolling' },
  -- { 'gr', desc = 'Smart Rename' },

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
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
    spec = {
      { '<LocalLeader>f', group = ' File Browser' },
      { '<LocalLeader>t', group = ' Telescope' },
      {
        '<LocalLeader>tg',
        group = ' Version Control',
        icon = devicons.get_icons_by_extension()['git']['icon'],
      },
    }
  },
  keys = {
    {
      "<LocalLeader>?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "All Keymaps",
    },
  },
}
