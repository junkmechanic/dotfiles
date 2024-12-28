-- Setup lazy.nvim
require('lazy').setup {
  spec = {
    { import = 'plugins' },
  },
  install = { colorscheme = { 'nordfox' } },
  checker = { enabled = true },
  change_detection = {
    notify = false,
  },
}

vim.keymap.set('n', '<LocalLeader>a', function()
  require('lazy').home()
end, { noremap = true, silent = true, desc = 'Lazy Home' })

--[[
  {
    'mfussenegger/nvim-dap',
    requires = {
      'mfussenegger/nvim-dap-python',
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'jbyuki/one-small-step-for-vimkind',
    },
    config = function()
      require 'config.dap'
    end,
  }
  {
    'goolord/alpha-nvim',
    config = function()
      require 'config.alpha'
    end,
  }
--]]
