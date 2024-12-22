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
    "olimorris/persisted.nvim",
    lazy = false,
    priority = 100,
    config = function()
      require 'config.persisted'
    end,
  },
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require 'config.hlslens'
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      open_mapping = [[<C-\>]],
      start_in_insert = true,
      direction = 'float',
      close_on_exit = true,
      auto_scroll = true,
      float_opts = {
        border = 'single',
        winblend = 10,
      },
      winbar = {
        enabled = false,
      },
    }
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 1,
        width = 0.85,
        height = 0.98,
      },
    }
  },
}
