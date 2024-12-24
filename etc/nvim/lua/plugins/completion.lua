return {
  {
    'hrsh7th/nvim-cmp',
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-cmdline',
      'dmitmel/cmp-cmdline-history',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lua',
      -- 'hrsh7th/cmp-nvim-lsp',
      -- 'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'lukas-reineke/cmp-rg',
      'f3fora/cmp-spell',
      -- 'ray-x/cmp-treesitter',
      'onsails/lspkind-nvim',
    },
    config = function()
      require 'config.completion'
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    version = "v2.*",
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require 'config.luasnip'
    end,
  },
}
