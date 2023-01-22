local actions = require 'telescope.actions'
local fb_actions = require('telescope').extensions.file_browser.actions

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

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
    prompt_prefix = '  ',
    selection_caret = ' ',
  },
  pickers = {
    git_files = {
      show_untracked = true,
    },
    current_buffer_fuzzy_find = {
      skip_empty_lines = true,
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
require('telescope').load_extension 'fzf'
require('telescope').load_extension 'frecency'
require('telescope').load_extension 'neoclip'
require('telescope').load_extension 'ui-select'
require('telescope').load_extension 'file_browser'
require('telescope').load_extension 'persisted'

require('telescope-tabs').setup {
  show_preview = false,
}

map('n', '<C-p>', "<Cmd>lua require'config.telescope-ext'.project_files()<CR>", opts)
map('n', '<C-n>', ':Telescope frecency<CR>', opts)

local options = {
  mode = 'n',
}

local mappings = {
  ['<LocalLeader>'] = {
    g = { '<Cmd>Telescope live_grep<CR>', 'Search Codebase' },
    s = { '<Cmd>Telescope grep_string<CR>', 'Search Cursor-word' },
    l = { '<Cmd>Telescope current_buffer_fuzzy_find<CR>', 'Search in file' },
    h = { '<Cmd>Telescope help_tags<CR>', 'Search Help Tags' },
    r = { '<Cmd>Telescope resume<CR>', 'Resume Search' },

    f = {
      name = ' File Browser',
      f = {
        "<Cmd>lua require'config.telescope-ext'.file_browser()<CR>",
        'File Browser in $CWD',
      },
      h = {
        "<Cmd>lua require'config.telescope-ext'.home_explorer()<CR>",
        'File Browser in $HOME',
      },
      d = {
        "<Cmd>lua require'config.telescope-ext'.browse_file_dir()<CR>",
        'File Browser in File Dir',
      },
      p = {
        "<Cmd>lua require'config.telescope-ext'.browse_plugin_dir()<CR>",
        'File Browser in Neovim Plugin Dir',
      },
    },

    t = {
      name = ' Telescope Built-ins',
      b = { '<Cmd>Telescope git_branches<CR>', 'Branches' },
      c = { '<Cmd>Telescope commands<CR>', 'Commands' },
      d = {
        name = ' DAP',
        b = { '<Cmd>Telescope dap list_breakpoints<CR>', 'Breakpoints' },
        c = { '<Cmd>Telescope dap commands<CR>', 'Commands' },
        f = { '<Cmd>Telescope dap frames<CR>', 'Frames' },
        g = { '<Cmd>Telescope dap configurations<CR>', 'Configurations' },
        v = { '<Cmd>Telescope dap variables<CR>', 'Variables' },
      },
      g = { '<Cmd>Telescope git_commits<CR>', 'Commits' },
      h = { '<Cmd>Telescope highlights<CR>', 'Highlights' },
      k = { '<Cmd>Telescope keymaps<CR>', 'Mappings' },
      m = { '<Cmd>Telescope git_bcommits<CR>', 'Buffer Commits' },
      p = { '<Cmd>Telescope persisted<CR>', 'Sessions' },
      s = { '<Cmd>Telescope git_status<CR>', 'Git Status' },
      v = { '<Cmd>Telescope vim_options<CR>', 'Nvim Options' },
    },
  },

  ['<C-s>'] = { "<Cmd>lua require'telescope-tabs'.list_tabs()<CR>", 'Search Tabs' },
}

wk.register(mappings, options)
