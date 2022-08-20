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

function M.file_explorer()
  require('telescope').extensions.file_browser.file_browser {
    prompt_title = '',
    cwd = '~',
  }
end

function M.browse_file_dir()
  require('telescope').extensions.file_browser.file_browser {
    prompt_title = '',
    path = '%:p:h',
  }
end

return M
