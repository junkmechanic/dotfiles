return {
  {
    'smoka7/hop.nvim',
    version = "*",
    config = function()
      require 'config.hop'
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-frecency.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      -- 'nvim-telescope/telescope-dap.nvim',
      'LukasPietzschmann/telescope-tabs',
      'paopaol/telescope-git-diffs.nvim',
      'debugloop/telescope-undo.nvim',
      'polirritmico/telescope-lazy-plugins.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      {
        'AckslD/nvim-neoclip.lua',
        dependencies = {
          { 'kkharji/sqlite.lua', module = 'sqlite' },
        },
        config = function()
          require 'config.neoclip'
        end,
      },
    },
    config = function()
      require 'config.telescope'
    end,
  },
}
