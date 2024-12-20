return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require 'config.nvim-tree'
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {
      check_ts = true,
      fast_wrap = {
        map = '<M-e>',
      },
    }
  },
  {
    'tummetott/unimpaired.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'kylechui/nvim-surround',
    version = "*",
    event = "VeryLazy",
    config = function()
      require('nvim-surround').setup()
    end,
  },
  {
    'rjayatilleka/vim-insert-char',
    keys = { { '<space>', mode = 'n' } },
  },
}
