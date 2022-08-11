-- Bootstrapping packer
local fn = vim.fn

-- stdpath('data') is `~/.local/share/nvim`
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  PackerBootstrap = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
end

-- Reload packer config when saving this file
vim.api.nvim_create_augroup('PackerUserConfig', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'PackerUserConfig',
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerSync',
})

-- Protected call to load packer
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Custom packer initialisatioon
packer.init {

  max_jobs = 40,

  -- Have packer use a popup window
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

packer.startup(function()
  use 'wbthomason/packer.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'tpope/vim-fugitive'
  use 'nvim-lua/plenary.nvim'
  use 'tpope/vim-unimpaired'
  use {
    'lewis6991/impatient.nvim',
    config = function()
      require 'impatient'
    end,
  }
  use {
    'EdenEast/nightfox.nvim',
    config = function()
      require 'config.nightfox'
    end,
  }
  use {
    'petertriho/nvim-scrollbar',
    config = function()
      require 'config.scrollbar'
    end,
  }
  use {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require 'config.hlslens'
    end,
  }
  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require 'config.nvim-tree'
    end,
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  }
  use {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require 'config.hop'
    end,
  }
  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'config.lualine'
    end,
  }
  use {
    'ellisonleao/glow.nvim',
    ft = { 'md', 'markdown' },
    config = function()
      require 'config.glow'
    end,
  }
  use {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end,
    keys = {
      { 'n', 'cs' },
      { 'n', 'ds' },
      { 'n', 'ys' },
      { 'x', 'S' },
    },
  }
  use {
    'rjayatilleka/vim-insert-char',
    keys = { { 'n', '<space>' } },
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      require 'config.autopairs'
    end,
  }
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/nvim-lsp-installer',
      'onsails/lspkind-nvim',
      'SmiteshP/nvim-navic',
    },
    config = function()
      require 'config.lsp'
    end,
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'f3fora/cmp-spell',
      'hrsh7th/cmp-calc',
      'lukas-reineke/cmp-rg',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'dmitmel/cmp-cmdline-history',
    },
    config = function()
      require 'config.completion'
    end,
  }
  use {
    'folke/trouble.nvim',
    config = function()
      require 'config.trouble'
    end,
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-refactor',
      'drybalka/tree-climber.nvim',
    },
    run = function()
      require('nvim-treesitter.install').update { with_sync = true }
    end,
    config = function()
      require 'config.treesitter'
    end,
  }
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = {
      'tami5/sqlite.lua',
      'nvim-telescope/telescope-frecency.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      {
        'AckslD/nvim-neoclip.lua',
        requires = {
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
  }
  use {
    'TimUntersberger/neogit',
    config = function()
      require 'config.neogit'
    end,
  }
  use {
    'sindrets/diffview.nvim',
    config = function()
      require 'config.diffview'
    end,
  }
  use {
    'akinsho/toggleterm.nvim',
    tag = 'v2.*',
    config = function()
      require 'config.toggleterm'
    end,
  }
  use {
    'mcauley-penney/tidy.nvim',
    config = function()
      require 'config.tidy'
    end,
  }
  use {
    'goolord/alpha-nvim',
    config = function()
      require 'config.alpha'
    end,
  }
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require 'config.null-ls'
    end,
  }
  use {
    'j-hui/fidget.nvim',
    config = function()
      require 'config.fidget'
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PackerBootstrap then
    require('packer').sync()
  end
end)
