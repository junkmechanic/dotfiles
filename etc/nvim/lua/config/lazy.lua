-- Setup lazy.nvim
require 'lazy'.setup {
  spec = {
    { import = 'plugins' },
  },
  install = { colorscheme = { 'nordfox' } },
  checker = { enabled = true },
  change_detection = {
    notify = false
  }
}

vim.keymap.set(
  'n',
  '<LocalLeader>a',
  function() require 'lazy'.home() end,
  { noremap = true, silent = true, desc = 'Lazy Home' }
)

--[[
packer.startup(function(use)
  use {
    'numToStr/Comment.nvim',
    config = function()
      require 'Comment'.setup()
    end,
  }
  use {
    'jose-elias-alvarez/null-ls.nvim',
    after = 'mason.nvim',
    config = function()
      require 'config.null-ls'
    end,
  }
  use {
    'amrbashir/nvim-docs-view',
    cmd = { 'DocsViewToggle' },
    config = function()
      require 'config.docs-view'
    end,
  }
  use {
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
  use {
    'simrat39/symbols-outline.nvim',
    config = function()
      require 'config.symbols-outline'
    end,
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'ziontee113/syntax-tree-surfer',
      'nvim-treesitter/playground',
    },
    run = function()
      require 'nvim-treesitter.install'.update { with_sync = true }
    end,
    config = function()
      require 'config.treesitter'
    end,
  }
  use {
    'abecodes/tabout.nvim',
    wants = { 'nvim-treesitter' },
    after = { 'nvim-cmp' },
    config = function()
      require 'config.tabout'
    end,
  }
  use {
    'goolord/alpha-nvim',
    config = function()
      require 'config.alpha'
    end,
  }
  use {
    'j-hui/fidget.nvim',
    branch = 'legacy',
    config = function()
      require 'config.fidget'
    end,
  }
  use {
    'folke/twilight.nvim',
    config = function()
      require 'config.twilight'
    end,
  }
  use {
    'gorbit99/codewindow.nvim',
    config = function()
      require 'config.codewindow'
    end,
  }
end)
--]]
