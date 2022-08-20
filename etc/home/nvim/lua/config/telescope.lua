local actions = require 'telescope.actions'
local fb_actions = require('telescope').extensions.file_browser.actions

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<C-p>', "<Cmd>lua require'config.telescope-ext'.project_files()<CR>", opts)
map('n', '<C-n>', ':Telescope frecency<CR>', opts)
map('n', '<Leader>r', ':Telescope lsp_references<CR>', opts)
map('n', '<LocalLeader>g', ':Telescope live_grep<CR>', opts)
map('n', '<LocalLeader>s', ':Telescope grep_string<CR>', opts)
map('n', '<LocalLeader>r', ':Telescope resume<CR>', opts)
map('n', '<LocalLeader>l', ':Telescope current_buffer_fuzzy_find<CR>', opts)
map('n', '<LocalLeader>h', ':Telescope help_tags<CR>', opts)
map('n', '<LocalLeader>ff', "<Cmd>lua require'config.telescope-ext'.file_browser()<CR>", opts)
map('n', '<LocalLeader>fh', "<Cmd>lua require'config.telescope-ext'.file_explorer()<CR>", opts)
map('n', '<LocalLeader>fd', "<Cmd>lua require'config.telescope-ext'.browse_file_dir()<CR>", opts)
map('n', '<LocalLeader>dd', ':Telescope diagnostics<CR>', opts)

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

require('telescope').load_extension 'fzf'
require('telescope').load_extension 'frecency'
require('telescope').load_extension 'neoclip'
require('telescope').load_extension 'ui-select'
require('telescope').load_extension 'file_browser'
