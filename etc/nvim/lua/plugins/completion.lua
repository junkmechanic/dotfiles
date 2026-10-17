return {
  {
    'saghen/blink.cmp',
    -- A release tag pulls the prebuilt fuzzy matcher binary instead of building it
    version = '1.*',
    -- blink lazy-loads itself; loading it early lets it register its LSP capabilities
    lazy = false,
    dependencies = {
      'L3MON4D3/LuaSnip',
      'mikavilpas/blink-ripgrep.nvim',
      'ribru17/blink-cmp-spell',
      'mgalliou/blink-cmp-tmux',
      'yaocccc/blink-cmp-cmdlinehistory',
    },
    config = function()
      require 'config.completion'
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require 'config.luasnip'
    end,
  },
}
