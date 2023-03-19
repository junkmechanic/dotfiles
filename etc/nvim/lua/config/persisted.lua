local local_config = require 'config.local-config'

vim.o.sessionoptions = 'buffers,curdir,folds,globals,tabpages,winpos,winsize'

require('persisted').setup {
  use_git_branch = true,
  allowed_dirs = local_config.persisted_allowed_dirs,
  autosave = true,
  should_autosave = function()
    if vim.bo.filetype == 'alpha' then
      return false
    end
    return true
  end,
  on_autoload_no_session = function()
    local msg = ' No existing session to load.'
    local ok = pcall(require 'notify', msg)
    if not ok then
      vim.notify(msg)
    end
  end,
}
