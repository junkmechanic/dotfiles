return {
  {
    'rafcamlet/nvim-luapad',
    cmd = { 'Laupad', 'LuaRun' },
    keys = {
      { '<LocalLeader>q', "<Cmd>lua require('luapad').init()<CR>", desc = 'Luapad' },
    },
  },
  {
    'williamboman/mason.nvim',
    dependencies = {
      {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
          ensure_installed = {
            -- Install packages not supported by `mason-null-ls` yet
            'deno',
          },
        },
      },
      'williamboman/mason-lspconfig.nvim',
      'jayp0521/mason-null-ls.nvim',
      {
        'jayp0521/mason-nvim-dap.nvim',
        opts = {
          ensure_installed = { 'bash' },
        },
      },
    },
    opts = {
      ui = {
        border = 'single',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'SmiteshP/nvim-navic',
      {
        'rmagatti/goto-preview',
        event = 'BufEnter',
        config = true,
      },
      {
        'folke/trouble.nvim',
        opts = {
          win = {
            wo = {
              colorcolumn = '',
            },
          },
        },
      },
    },
    config = function()
      require 'config.lsp'
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require 'config.null-ls'
    end,
  },
  {
    'amrbashir/nvim-docs-view',
    cmd = { 'DocsViewToggle' },
    config = function()
      require 'config.docs-view'
    end,
  },
  {
    'j-hui/fidget.nvim',
    version = '*',
    config = true,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'ziontee113/syntax-tree-surfer',
      'nvim-treesitter/playground',
    },
    build = function()
      require('nvim-treesitter.install').update { with_sync = true }
    end,
    config = function()
      require 'config.treesitter'
    end,
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'mfussenegger/nvim-dap-python',
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'jbyuki/one-small-step-for-vimkind',
    },
    config = function()
      require 'config.dap'
    end,
  },
}
