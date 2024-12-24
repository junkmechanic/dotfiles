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
  {
    "nvimtools/hydra.nvim",
    dependencies = {
      'sindrets/winshift.nvim',
      'mrjones2014/smart-splits.nvim',
    },
    config = function()
      require 'config.hydra'
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      require("lazy").load { plugins = { "markdown-preview.nvim" } }
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      window = {
        winblend = 10,
      },
    },
    keys = {
      { '<LocalLeader>u', "<Cmd>lua require('undotree').toggle()<CR>", desc = 'Undo Tree' },
    },
  },
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    opts = {
      width = 160,
      height = 120,
      width_ratio = 0.8,
      height_ratio = 0.8,
      border = 'solid',
    }
  },
  {
    'rafcamlet/nvim-luapad',
    ft = { "lua" },
    cmd = { "Laupad", "LuaRun" },
    keys = {
      { '<LocalLeader>q', "<Cmd>lua require('luapad').init()<CR>", desc = 'Luapad' },
    },
  },
}
