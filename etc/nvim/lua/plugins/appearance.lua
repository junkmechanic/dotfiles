return {
  {
    'petertriho/nvim-scrollbar',
    opts = {},
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require 'config.lualine'
    end,
  },
}
