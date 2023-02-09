require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    'bash',
    'c',
    'dockerfile',
    'hcl',
    'help',
    'json',
    'lua',
    'make',
    'markdown',
    'python',
    'query',
    'sql',
    'vim',
    'yaml',
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    enable = true,
    -- NOTE: these are the names of the parsers and not the filetype. (for example if you
    -- want to disable highlighting for the `tex` filetype, you need to include `latex` in
    -- this list as this is the name of the parser)
    -- list of language that will be disabled
    disable = { 'sql' },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time. Set
    -- this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate
    -- highlights. Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<Tab>',
      node_decremental = '<S-Tab>',
    },
  },
  refactor = {
    highlight_definitions = {
      enable = true,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = true,
    },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = 'gr',
      },
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['ac'] = '@conditional.outer',
        ['ic'] = '@conditional.inner',
        ['a,'] = '@parameter.outer',
        ['i,'] = '@parameter.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<Leader>w'] = '@parameter.inner',
      },
      swap_previous = {
        ['<Leader>W'] = '@parameter.inner',
      },
    },
  },
  playground = {
    enable = true,
  },
}

require('treesitter-context').setup {}
