---@diagnostic disable-next-line: missing-fields
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'bash',
    'c',
    'dockerfile',
    'gitcommit',
    'gitignore',
    'hcl',
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
    disable = { 'sql', 'gitcommit' },

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

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- Swap Current Node at the Cursor with it's siblings
map('n', '<LocalLeader>pw', function()
  vim.opt.opfunc = 'v:lua.STSSwapCurrentNodeNextNormal_Dot'
  return 'g@l'
end, 'Swap Node with next')
map('n', '<LocalLeader>pW', function()
  vim.opt.opfunc = 'v:lua.STSSwapCurrentNodePrevNormal_Dot'
  return 'g@l'
end, 'Swap Node with previous')

-- Swapping Nodes in Visual Mode
map('x', '<LocalLeader>pw', '<Cmd>STSSwapNextVisual<CR>', 'Swap Node with next')
map('x', '<LocalLeader>pW', '<Cmd>STSSwapPrevVisual<CR>', 'Swap Node with previous')

-- Visual Selection from Normal Mode
map('n', 'vx', '<Cmd>STSSelectMasterNode<CR>', 'Select Master Node')
map('n', 'vn', '<Cmd>STSSelectCurrentNode<CR>', 'Select Current Node')

-- Select Nodes in Visual Mode
map('x', 'J', '<Cmd>STSSelectNextSiblingNode<CR>', 'Select Next Sibling Node')
map('x', 'K', '<Cmd>STSSelectPrevSiblingNode<CR>', 'Select Prev Sibling Node')
map('x', 'H', '<Cmd>STSSelectParentNode<CR>', 'Select Parent Node')
map('x', 'L', '<Cmd>STSSelectChildNode<CR>', 'Select Child Node')
