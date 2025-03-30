local telescope = require 'telescope'
local actions = require 'telescope.actions'
local builtin = require 'telescope.builtin'
local utils = require 'telescope.utils'

telescope.setup {
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
        ['<C-s>'] = actions.select_horizontal,
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
        -- this will always open a new tab on hitting enter
        -- you might want to add this mapping to `find_files` and other relevant pickers
        -- i = {
        --   ['<CR>'] = function(bufnr)
        --     require('telescope.actions.set').edit(bufnr, 'tab drop')
        --   end,
        -- },
      },
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
      respect_gitignore = false,
      mappings = {
        ['i'] = {
          ['<C-t>'] = actions.select_tab,
        },
      },
    },
  },
}

telescope.load_extension 'dap'
telescope.load_extension 'file_browser'
telescope.load_extension 'frecency'
telescope.load_extension 'fzf'
telescope.load_extension 'git_diffs'
telescope.load_extension 'lazy_plugins'
telescope.load_extension 'neoclip'
telescope.load_extension 'persisted'
telescope.load_extension 'ui-select'
telescope.load_extension 'undo'

require('telescope-tabs').setup {
  show_preview = false,
}

-- Mappings

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map('n', '<LocalLeader>t/', function()
  builtin.search_history()
end, 'Search History')

map('n', '<LocalLeader>tC', function()
  builtin.command_history()
end, 'Command History')

map('n', '<LocalLeader>tc', function()
  builtin.commands()
end, 'Commands')

map('n', '<LocalLeader>tf', function()
  builtin.buffers()
end, 'Buffers')

map('n', '<LocalLeader>th', function()
  builtin.highlights()
end, 'Highlights')

map('n', '<LocalLeader>tk', function()
  builtin.keymaps()
end, 'Mappings')

map('n', '<LocalLeader>tp', function()
  builtin.builtin()
end, 'Builtin Pickers')

map('n', '<LocalLeader>ts', function()
  builtin.persisted()
end, 'Sessions')

map('n', '<LocalLeader>tu', function()
  telescope.extensions.undo.undo()
end, 'Undo Tree')

map('n', '<LocalLeader>tv', function()
  builtin.vim_options()
end, 'Nvim Options')

map('n', '<LocalLeader>tn', function()
  require('telescope').extensions.notify.notify()
end, 'Notify History')

map('n', '<LocalLeader>tl', function()
  telescope.extensions.lazy_plugins.lazy_plugins()
end, 'Lazy Config')

map('n', '<LocalLeader>tgb', function()
  builtin.git_branches()
end, 'Branches')

map('n', '<LocalLeader>tgc', function()
  builtin.git_commits()
end, 'Commits')

map('n', '<LocalLeader>tgd', function()
  telescope.extensions.git_diffs.diff_commits()
end, 'Commit Diffs')

map('n', '<LocalLeader>tgm', function()
  builtin.git_bcommits()
end, 'Buffer Commits')

map('n', '<LocalLeader>tgs', function()
  builtin.git_status()
end, 'Git Status')

map('n', '<LocalLeader>g', function()
  builtin.live_grep()
end, 'Search Codebase')

map('n', '<LocalLeader>h', function()
  builtin.help_tags()
end, 'Search Help Tags')

map('n', '<LocalLeader>r', function()
  builtin.resume()
end, 'Resume Search')

map('n', '<LocalLeader>s', function()
  builtin.grep_string()
end, 'Search Cursor-word')

map('n', '<C-s>', function()
  require('telescope-tabs').list_tabs()
end, 'Search for Tabs')

-- map('n', '<LocalLeader>l', function()
--   builtin.current_buffer_fuzzy_find()
-- end, 'Search in Current File')

map('n', '<C-n>', function()
  telescope.extensions.frecency.frecency {
    workspace = 'CWD',
    prompt_title = 'Frecency',
  }
end, 'Search for Frequent Files')

local function project_files()
  local opts = {}

  local _, ret, _ = utils.get_os_command_output {
    'git',
    'rev-parse',
    '--is-inside-work-tree',
  }

  if ret == 0 then
    opts.prompt_title = ' ' .. vim.fn.getcwd()
    opts.results_title = ''
    require('telescope.builtin').git_files(opts)
  else
    opts.prompt_title = ' ' .. vim.fn.getcwd()
    opts.results_title = ''
    require('telescope.builtin').find_files(opts)
  end
end

map('n', '<C-p>', function()
  project_files()
end, 'Search for Project Files')

local function file_browser()
  telescope.extensions.file_browser.file_browser {
    prompt_title = ' ' .. vim.fn.getcwd(),
  }
end

map('n', '<LocalLeader>ff', function()
  file_browser()
end, 'File Browser in $CWD')

local function browse_file_dir()
  telescope.extensions.file_browser.file_browser {
    prompt_title = ' ' .. vim.fn.expand '%:p:h',
    path = '%:p:h',
  }
end

map('n', '<LocalLeader>fd', function()
  browse_file_dir()
end, 'File Browser in File Dir')

local function home_explorer()
  telescope.extensions.file_browser.file_browser {
    prompt_title = ' Home',
    cwd = '~',
  }
end

map('n', '<LocalLeader>fh', function()
  home_explorer()
end, 'File Browser in $HOME')

local function browse_plugin_dir()
  telescope.extensions.file_browser.file_browser {
    prompt_title = ' ' .. '~/.local/share/nvim/lazy',
    path = '~/.local/share/nvim/lazy',
  }
end

map('n', '<LocalLeader>fp', function()
  browse_plugin_dir()
end, 'File Browser in Neovim Plugin Dir')
