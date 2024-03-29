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
      name = ' Telescope',
      c = { '<Cmd>Telescope commands<CR>', 'Commands' },
      C = { '<Cmd>Telescope command_history<CR>', 'Command History' },
      f = { '<Cmd>Telescope buffers<CR>', 'Buffers' },
      h = { '<Cmd>Telescope highlights<CR>', 'Highlights' },
      k = { '<Cmd>Telescope keymaps<CR>', 'Mappings' },
      p = { '<Cmd>Telescope builtin<CR>', 'Builtin Pickers' },
      s = { '<Cmd>Telescope persisted<CR>', 'Sessions' },
      u = { '<Cmd>Telescope undo<CR>', 'Undo Tree' },
      v = { '<Cmd>Telescope vim_options<CR>', 'Nvim Options' },
      ['/'] = { '<Cmd>Telescope search_history<CR>', 'Search History' },

      g = {
        name = ' Version Control',
        b = { '<Cmd>Telescope git_branches<CR>', 'Branches' },
        c = { '<Cmd>Telescope git_commits<CR>', 'Commits' },
        d = { '<Cmd>Telescope git_diffs diff_commits<CR>', 'Commit Diffs' },
        m = { '<Cmd>Telescope git_bcommits<CR>', 'Buffer Commits' },
        s = { '<Cmd>Telescope git_status<CR>', 'Git Status' },
        v = { '<Cmd>DiffviewOpen<CR>', 'Diffview' },
        w = { '<Cmd>DiffviewFileHistory %<CR>', 'Diffview Current File' },
      },
    },
  },

  ['<C-s>'] = { "<Cmd>lua require'telescope-tabs'.list_tabs()<CR>", 'Search Tabs' },
}

wk.register(mappings, options)
