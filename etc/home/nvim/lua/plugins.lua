-- Bootstrapping packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

-- Reload packer config when saving this file
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup('PackerUserConfig', { clear = true })
autocmd('BufWritePost', {
  group = 'PackerUserConfig',
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile",
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

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
