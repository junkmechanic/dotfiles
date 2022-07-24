-- Bootstrapping packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  PackerBootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

-- Reload packer config when saving this file
vim.api.nvim_create_augroup('PackerUserConfig', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'PackerUserConfig',
  pattern = "plugins.lua",
  command = "source <afile> | PackerSync",
})

-- Protected call to load packer
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Custom packer initialisatioon
packer.init({

  -- Limit the number of simultaneous jobs. nil means no limit. Set to 20 in
  -- order to prevent PackerSync form being "stuck" ->
  -- https://github.com/wbthomason/packer.nvim/issues/746
  max_jobs = 20,

  -- Have packer use a popup window
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

packer.startup(function()
  use "wbthomason/packer.nvim"
  use {
    "EdenEast/nightfox.nvim",
    config = function()
      require("config.nightfox")
    end
  }
  use "kyazdani42/nvim-web-devicons"
  use {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("config.nvim-tree")
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }
  use {
    'feline-nvim/feline.nvim',
    config = function()
      require("config.feline")
    end
  }
  use {
    "nanozuki/tabby.nvim",
    config = function()
      require("config.tabby")
    end
  }
  use {
    "ellisonleao/glow.nvim",
    ft = { "md", "markdown" }
  }
  use {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
    keys = {
      { "n", 'cs' },
      { "n", "ds" },
      { "n", "ys" },
      { "x", 'S' },
    }
  }
  use {
    "rjayatilleka/vim-insert-char",
    keys = { { "n", "<space>" } }
  }
  use {
	"windwp/nvim-autopairs",
    -- TODO: include nvim-cmp config
    config = function()
      require("nvim-autopairs").setup()
    end
  }
  use {
    "williamboman/nvim-lsp-installer",
    requires = "neovim/nvim-lspconfig",
    config = function()
      require("config.lsp")
    end
  }
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-calc",
      "lukas-reineke/cmp-rg",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = function()
      require("config.completion")
    end
  })
  use {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup { }
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PackerBootstrap then
    require('packer').sync()
  end
end)
