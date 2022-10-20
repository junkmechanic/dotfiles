local utils = require 'telescope.utils'

local M = {}

function M.project_files()
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

function M.file_browser()
  require('telescope').extensions.file_browser.file_browser {
    prompt_title = ' ' .. vim.fn.getcwd(),
  }
end

function M.home_explorer()
  require('telescope').extensions.file_browser.file_browser {
    prompt_title = ' Home',
    cwd = '~',
  }
end

function M.browse_file_dir()
  require('telescope').extensions.file_browser.file_browser {
    prompt_title = ' ' .. vim.fn.expand '%:p:h',
    path = '%:p:h',
  }
end

function M.browse_plugin_dir()
  require('telescope').extensions.file_browser.file_browser {
    prompt_title = ' ' .. '~/.local/share/nvim/site/pack/packer',
    path = '~/.local/share/nvim/site/pack/packer',
  }
end

return M
