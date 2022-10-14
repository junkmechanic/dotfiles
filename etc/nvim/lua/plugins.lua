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
  use 'nvim-lua/plenary.nvim'
  use 'simnalamburt/vim-mundo'
  use 'tpope/vim-unimpaired'
  use 'rcarriga/nvim-notify'
  use 'mrjones2014/smart-splits.nvim'
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
      require('scrollbar').setup()
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
      require 'config.gitsigns'
    end,
  }
  use {
    'tpope/vim-fugitive',
    config = function()
      require 'config.fugitive'
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
  -- Load `lualine` after setting the colorscheme
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
    'williamboman/mason.nvim',
    config = function()
      require 'config.mason'
    end,
  }
  -- mason-lspconfig will be setup with lsp
  use { 'williamboman/mason-lspconfig.nvim' }
  -- mason and its extensions should be setup before lsp
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'onsails/lspkind-nvim',
      'SmiteshP/nvim-navic',
    },
    config = function()
      require 'config.lsp'
    end,
  }
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require 'config.null-ls'
    end,
  }
  use {
    'L3MON4D3/LuaSnip',
    requires = {
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require 'config.luasnip'
    end,
  }
  use {
    'simrat39/symbols-outline.nvim',
    config = function()
      require 'config.symbols-outline'
    end,
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'dmitmel/cmp-cmdline-history',
      'f3fora/cmp-spell',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'lukas-reineke/cmp-rg',
      'ray-x/cmp-treesitter',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      require 'config.completion'
    end,
  }
  use {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup()
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
      'nvim-telescope/telescope-file-browser.nvim',
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
    'anuvyklack/hydra.nvim',
    config = function()
      require 'config.hydra'
    end,
  }
  use {
    'j-hui/fidget.nvim',
    config = function()
      require 'config.fidget'
    end,
  }
  use {
    'folke/zen-mode.nvim',
    config = function()
      require 'config.zen-mode'
    end,
  }
  use {
    'olimorris/persisted.nvim',
    config = function()
      require 'config.persisted'
    end,
  }
  use {
    'folke/which-key.nvim',
    config = function()
      require 'config.which-key'
    end,
  }
  use {
    'sindrets/winshift.nvim',
    config = function()
      require('winshift').setup()
    end,
  }
  use {
    'iamcco/markdown-preview.nvim',
    run = function()
      vim.fn['mkdp#util#install']()
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PackerBootstrap then
    require('packer').sync()
  end
end)
