local actions = require 'telescope.actions'
local fb_actions = require('telescope').extensions.file_browser.actions

local map = vim.keymap.set

local wk = require 'which-key'

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<Esc>'] = actions.close,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-b>'] = actions.results_scrolling_up,
        ['<C-f>'] = actions.results_scrolling_down,
        ['<C-p>'] = actions.preview_scrolling_up,
        ['<C-n>'] = actions.preview_scrolling_down,
        ['<C-u>'] = false,
      },
    },
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
    winblend = 10,
    dynamic_preview_title = true,
    prompt_prefix = ' 󰍉 ',
    selection_caret = ' ',
  },
  pickers = {
    git_files = {
      show_untracked = true,
      mappings = {
        i = {
          ['<CR>'] = function(bufnr)
            require('telescope.actions.set').edit(bufnr, 'tab drop')
          end,
        },
      },
    },
    current_buffer_fuzzy_find = {
      skip_empty_lines = true,
    },
    find_files = {
      mappings = {
        i = {
          ['<CR>'] = function(bufnr)
            require('telescope.actions.set').edit(bufnr, 'tab drop')
          end,
        },
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
    frecency = {
      ignore_patterns = { '*.git/*', '*/tmp/*', '*pycache*' },
      workspaces = {
        ['conf'] = '/Users/ankur/.config',
        ['df'] = '/Users/ankur/.files',
        ['dev'] = '/Users/ankur/devbench',
      },
    },
    ['ui-select'] = {
      require('telescope.themes').get_dropdown {},
    },
    file_browser = {
      theme = 'ivy',
      hidden = true,
      respect_gitignore = false,
      mappings = {
        ['i'] = {
          ['<C-a>'] = fb_actions.create,
          ['<A-h>'] = fb_actions.goto_home_dir,
          ['<C-t>'] = actions.select_tab,
          ['<A-t>'] = fb_actions.change_cwd,
        },
      },
    },
  },
}

require('telescope').load_extension 'dap'
require('telescope').load_extension 'file_browser'
require('telescope').load_extension 'frecency'
require('telescope').load_extension 'fzf'
require('telescope').load_extension 'git_diffs'
require('telescope').load_extension 'neoclip'
require('telescope').load_extension 'persisted'
require('telescope').load_extension 'ui-select'
require('telescope').load_extension 'undo'

require('telescope-tabs').setup {
  show_preview = false,
}

local opts = { noremap = true, silent = true }

map('n', '<C-p>', "<Cmd>lua require'config.telescope-ext'.project_files()<CR>", opts)
map(
  'n',
  '<C-n>',
  "<Cmd>lua require('telescope').extensions.frecency.frecency({ workspace = 'CWD' })<CR>",
  opts
)
map('n', '<C-s>', "<Cmd>lua require'telescope-tabs'.list_tabs()<CR>", opts)

wk.add {
  { '<LocalLeader>g', '<Cmd>Telescope live_grep<CR>', desc = 'Search Codebase' },
  { '<LocalLeader>h', '<Cmd>Telescope help_tags<CR>', desc = 'Search Help Tags' },
  {
    '<LocalLeader>l',
    '<Cmd>Telescope current_buffer_fuzzy_find<CR>',
    desc = 'Search in file',
  },
  { '<LocalLeader>r', '<Cmd>Telescope resume<CR>', desc = 'Resume Search' },
  { '<LocalLeader>s', '<Cmd>Telescope grep_string<CR>', desc = 'Search Cursor-word' },

  { '<LocalLeader>f', group = ' File Browser' },
  {
    '<LocalLeader>fd',
    "<Cmd>lua require'config.telescope-ext'.browse_file_dir()<CR>",
    desc = 'File Browser in File Dir',
  },
  {
    '<LocalLeader>ff',
    "<Cmd>lua require'config.telescope-ext'.file_browser()<CR>",
    desc = 'File Browser in $CWD',
  },
  {
    '<LocalLeader>fh',
    "<Cmd>lua require'config.telescope-ext'.home_explorer()<CR>",
    desc = 'File Browser in $HOME',
  },
  {
    '<LocalLeader>fp',
    "<Cmd>lua require'config.telescope-ext'.browse_plugin_dir()<CR>",
    desc = 'File Browser in Neovim Plugin Dir',
  },

  { '<LocalLeader>t', group = ' Telescope' },
  { '<LocalLeader>t/', '<Cmd>Telescope search_history<CR>', desc = 'Search History' },
  { '<LocalLeader>tC', '<Cmd>Telescope command_history<CR>', desc = 'Command History' },
  { '<LocalLeader>tc', '<Cmd>Telescope commands<CR>', desc = 'Commands' },
  { '<LocalLeader>tf', '<Cmd>Telescope buffers<CR>', desc = 'Buffers' },
  { '<LocalLeader>th', '<Cmd>Telescope highlights<CR>', desc = 'Highlights' },
  { '<LocalLeader>tk', '<Cmd>Telescope keymaps<CR>', desc = 'Mappings' },
  { '<LocalLeader>tp', '<Cmd>Telescope builtin<CR>', desc = 'Builtin Pickers' },
  { '<LocalLeader>ts', '<Cmd>Telescope persisted<CR>', desc = 'Sessions' },
  { '<LocalLeader>tu', '<Cmd>Telescope undo<CR>', desc = 'Undo Tree' },
  { '<LocalLeader>tv', '<Cmd>Telescope vim_options<CR>', desc = 'Nvim Options' },

  { '<LocalLeader>tg', group = ' Version Control' },
  { '<LocalLeader>tgb', '<Cmd>Telescope git_branches<CR>', desc = 'Branches' },
  { '<LocalLeader>tgc', '<Cmd>Telescope git_commits<CR>', desc = 'Commits' },
  {
    '<LocalLeader>tgd',
    '<Cmd>Telescope git_diffs diff_commits<CR>',
    desc = 'Commit Diffs',
  },
  { '<LocalLeader>tgm', '<Cmd>Telescope git_bcommits<CR>', desc = 'Buffer Commits' },
  { '<LocalLeader>tgs', '<Cmd>Telescope git_status<CR>', desc = 'Git Status' },
  { '<LocalLeader>tgv', '<Cmd>DiffviewOpen<CR>', desc = 'Diffview' },
  {
    '<LocalLeader>tgw',
    '<Cmd>DiffviewFileHistory %<CR>',
    desc = 'Diffview Current File',
  },
}
