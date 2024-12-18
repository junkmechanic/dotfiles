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
    'smoka7/hop.nvim',
    version = "*",
    config = function()
      require 'config.hop'
    end,
  },
}
