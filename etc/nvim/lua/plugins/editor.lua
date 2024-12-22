return {
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {
      check_ts = true,
      fast_wrap = {
        map = '<M-e>',
      },
    }
  },
  {
    'tummetott/unimpaired.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'kylechui/nvim-surround',
    version = "*",
    event = "VeryLazy",
    config = function()
      require('nvim-surround').setup()
    end,
  },
  {
    'rjayatilleka/vim-insert-char',
    keys = { { '<space>', mode = 'n' } },
  },
  {
    "mcauley-penney/tidy.nvim",
    opts = {
        filetype_exclude = { "markdown", "diff" }
    },
  },
}
