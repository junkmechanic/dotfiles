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
      -- {
      --   'jayp0521/mason-nvim-dap.nvim',
      --   opts = {
      --     ensure_installed = { 'bash' },
      --   },
      -- },
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
}
