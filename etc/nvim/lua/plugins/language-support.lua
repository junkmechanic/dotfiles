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
          -- Formatters and linters wired up in config/conform.lua and config/lint.lua.
          -- `terraform fmt` and `zsh -n` use the system binaries, so they are absent.
          ensure_installed = {
            'beautysh',
            'cfn-lint',
            'cmakelang',
            'hadolint',
            'ktlint',
            'mypy',
            'prettier',
            'ruff',
            'shellcheck',
            'shfmt',
            'sqlfluff',
            'stylua',
          },
        },
      },
      'williamboman/mason-lspconfig.nvim',
      {
        'jay-babu/mason-nvim-dap.nvim',
        opts = {
          ensure_installed = { 'python', 'bash' },
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
      {
        'rmagatti/goto-preview',
        event = 'BufEnter',
        config = true,
      },
      {
        'folke/trouble.nvim',
        config = function()
          require 'config.trouble'
        end,
      },
    },
    config = function()
      require 'config.lsp'
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<LocalLeader>df',
        function()
          -- conform runs the CLI formatters and falls back to the LSP server
          -- when a filetype has none configured
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        desc = 'Format Buffer',
      },
    },
    config = function()
      require 'config.conform'
    end,
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require 'config.lint'
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
    branch = 'main',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
      -- playground is archived; use :InspectTree and :EditQuery (built-in since 0.10)
    },
    build = ':TSUpdate',
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
