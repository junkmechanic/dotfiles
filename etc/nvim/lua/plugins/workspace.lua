local devicons = require 'nvim-web-devicons'

return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require 'config.nvim-tree'
    end,
  },
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require 'config.oil'
    end,
  },
  {
    'olimorris/persisted.nvim',
    lazy = false,
    priority = 100,
    config = function()
      require 'config.persisted'
    end,
  },
  {
    'kevinhwang91/nvim-hlslens',
    dependencies = {
      {
        'petertriho/nvim-scrollbar',
        opts = {},
      },
    },
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
    },
  },
  {
    'folke/zen-mode.nvim',
    opts = {
      window = {
        backdrop = 1,
        width = 0.85,
        height = 0.98,
      },
    },
  },
  {
    'nvimtools/hydra.nvim',
    dependencies = {
      'sindrets/winshift.nvim',
      'mrjones2014/smart-splits.nvim',
    },
    config = function()
      require 'config.hydra'
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      require('lazy').load { plugins = { 'markdown-preview.nvim' } }
      vim.fn['mkdp#util#install']()
    end,
  },
  {
    'jiaoshijie/undotree',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {
      window = {
        winblend = 10,
      },
    },
    keys = {
      {
        '<LocalLeader>u',
        "<Cmd>lua require('undotree').toggle()<CR>",
        desc = 'Undo Tree',
      },
    },
  },
  {
    'ellisonleao/glow.nvim',
    cmd = 'Glow',
    opts = {
      width = 160,
      height = 120,
      width_ratio = 0.8,
      height_ratio = 0.8,
      border = 'solid',
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
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
        padding = { 1, 1 },
      },
      layout = {
        height = { min = 5, max = 25 },
        spacing = 5,
        align = 'center',
      },
      spec = {
        { '<LocalLeader>b', group = ' DAP' },
        { '<LocalLeader>f', group = ' File Browser' },
        { '<LocalLeader>t', group = ' Telescope' },
        { '<LocalLeader>p', group = ' Swap AST Nodes' },
        { '<LocalLeader>d', group = ' LSP Diagnostics' },
        { '<LocalLeader>dp', group = ' Preview' },
        {
          '<LocalLeader>tg',
          group = ' Version Control',
          icon = devicons.get_icons_by_extension()['git']['icon'],
        },
        {
          '<LocalLeader>v',
          group = ' VCS Actions',
          icon = devicons.get_icons_by_extension()['git']['icon'],
        },
        { 'gr', desc = 'Smart Rename' },
        { '<LocalLeader>u', icon = '' },
        { '<LocalLeader>n', icon = '󰙅' },
      },
    },
    keys = {
      {
        '<LocalLeader>?',
        function()
          require('which-key').show { global = true }
        end,
        desc = 'All Keymaps',
      },
    },
  },
  {
    'gorbit99/codewindow.nvim',
    config = function()
      require 'config.codewindow'
    end,
  },
  {
    'folke/twilight.nvim',
    opts = {
      context = 20,
    },
  },
  {
    'simrat39/symbols-outline.nvim',
    opts = {
      width = 20,
      winblend = 20,
    },
  },
}
