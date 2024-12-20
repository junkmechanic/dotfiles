return {
  {
    'tpope/vim-fugitive',
    config = function()
      require 'config.fugitive'
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'config.gitsigns'
    end,
  },
  {
    'sindrets/diffview.nvim',
    config = function()
      require 'config.diffview'
    end,
  },
}
