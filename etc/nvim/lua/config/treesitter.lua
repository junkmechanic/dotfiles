require('nvim-treesitter.configs').setup {
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
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['ac'] = '@conditional.outer',
        ['ic'] = '@conditional.inner',
        ['a,'] = '@parameter.outer',
        ['i,'] = '@parameter.inner',
      },
    },
    -- Swapping functionality is provided by syntax-tree-surfer
    -- swap = {
    --   enable = true,
    --   swap_next = {
    --     ['<Leader>w'] = '@parameter.inner',
    --   },
    --   swap_previous = {
    --     ['<Leader>W'] = '@parameter.inner',
    --   },
    -- },
  },
  playground = {
    enable = true,
  },
}

require('treesitter-context').setup {}

require('syntax-tree-surfer').setup {}

local opts = { noremap = true, silent = true }

-- Swap The Master Node relative to the cursor with it's siblings
vim.keymap.set('n', '<Leader>B', function()
  vim.opt.opfunc = 'v:lua.STSSwapUpNormal_Dot'
  return 'g@l'
end, { silent = true, expr = true })
vim.keymap.set('n', '<Leader>b', function()
  vim.opt.opfunc = 'v:lua.STSSwapDownNormal_Dot'
  return 'g@l'
end, { silent = true, expr = true })

-- Swap Current Node at the Cursor with it's siblings
vim.keymap.set('n', '<Leader>w', function()
  vim.opt.opfunc = 'v:lua.STSSwapCurrentNodeNextNormal_Dot'
  return 'g@l'
end, { silent = true, expr = true })
vim.keymap.set('n', '<Leader>W', function()
  vim.opt.opfunc = 'v:lua.STSSwapCurrentNodePrevNormal_Dot'
  return 'g@l'
end, { silent = true, expr = true })

-- Swapping Nodes in Visual Mode
vim.keymap.set('x', '<Leader>w', '<Cmd>STSSwapNextVisual<CR>', opts)
vim.keymap.set('x', '<Leader>W', '<Cmd>STSSwapPrevVisual<CR>', opts)

-- Visual Selection from Normal Mode
vim.keymap.set('n', 'vx', '<Cmd>STSSelectMasterNode<CR>', opts)
vim.keymap.set('n', 'vn', '<Cmd>STSSelectCurrentNode<CR>', opts)

-- Select Nodes in Visual Mode
vim.keymap.set('x', 'J', '<Cmd>STSSelectNextSiblingNode<CR>', opts)
vim.keymap.set('x', 'K', '<Cmd>STSSelectPrevSiblingNode<CR>', opts)
vim.keymap.set('x', 'H', '<Cmd>STSSelectParentNode<CR>', opts)
vim.keymap.set('x', 'L', '<Cmd>STSSelectChildNode<CR>', opts)
