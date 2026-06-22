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
  {
    'isakbm/gitgraph.nvim',
    config = function()
      require 'config.gitgraph'
    end,
    keys = {
      {
        '<LocalLeader>vg',
        function()
          vim.cmd ':tabnew'
          require('gitgraph').draw({}, { all = true, max_count = 5000 })
        end,
        desc = 'GitGraph',
      },
    },
  },
}
