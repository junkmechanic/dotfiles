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

--[[
packer.startup(function(use)
    use 'rcarriga/nvim-notify'
    use 'mrjones2014/smart-splits.nvim'
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'rbong/vim-flog',
        },
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
        'kevinhwang91/nvim-hlslens',
        config = function()
            require 'config.hlslens'
        end,
    }
    use {
        'nvim-lualine/lualine.nvim',
        after = 'nightfox.nvim',
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
        'rjayatilleka/vim-insert-char',
        keys = { { 'n', '<space>' } },
    }
    use {
        'williamboman/mason.nvim',
        config = function()
            require 'config.mason'
        end,
    }
    use { 'WhoIsSethDaniel/mason-tool-installer.nvim' }
    use { 'williamboman/mason-lspconfig.nvim' }
    use {
        'neovim/nvim-lspconfig',
        after = { 'mason.nvim', 'mason-lspconfig.nvim' },
        requires = {
            'onsails/lspkind-nvim',
            'SmiteshP/nvim-navic',
            'rmagatti/goto-preview',
        },
        config = function()
            require 'config.lsp'
        end,
    }
    use {
        'jose-elias-alvarez/null-ls.nvim',
        after = 'mason.nvim',
        config = function()
            require 'config.null-ls'
        end,
    }
    use { 'jayp0521/mason-null-ls.nvim' }
    use {
        'amrbashir/nvim-docs-view',
        cmd = { 'DocsViewToggle' },
        config = function()
            require 'config.docs-view'
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
        'mfussenegger/nvim-dap',
        requires = {
            'mfussenegger/nvim-dap-python',
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
            'jayp0521/mason-nvim-dap.nvim',
            'jbyuki/one-small-step-for-vimkind',
        },
        config = function()
            require 'config.dap'
        end,
    }
    use { 'rafcamlet/nvim-luapad' }
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
            'nvim-treesitter/nvim-treesitter-textobjects',
            'ziontee113/syntax-tree-surfer',
            'nvim-treesitter/playground',
        },
        run = function()
            require('nvim-treesitter.install').update { with_sync = true }
        end,
        config = function()
            require 'config.treesitter'
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
        branch = 'legacy',
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
        'folke/twilight.nvim',
        config = function()
            require 'config.twilight'
        end,
    }
    use {
        'olimorris/persisted.nvim',
        config = function()
            require 'config.persisted'
        end,
    }
    use {
        'gorbit99/codewindow.nvim',
        config = function()
            require 'config.codewindow'
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
    use {
        'ziontee113/icon-picker.nvim',
        config = function()
            require('icon-picker').setup {
                disable_legacy_commands = true,
            }
        end,
    }
end)
--]]
