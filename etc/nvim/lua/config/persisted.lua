local local_config = require 'config.local-config'

vim.o.sessionoptions = 'buffers,curdir,folds,globals,tabpages,winpos,winsize'

local function is_git_editor()
  if vim.fn.argc() == 0 then return false end
  local arg = vim.fn.argv(0)
  return arg:match 'COMMIT_EDITMSG' ~= nil
    or arg:match 'MERGE_MSG' ~= nil
    or arg:match 'SQUASH_MSG' ~= nil
    or arg:match 'REBASE_EDITMSG' ~= nil
    or arg:match 'git%-rebase%-todo' ~= nil
end

local function is_manpager()
  for _, arg in ipairs(vim.v.argv) do
    if arg == '+Man!' or arg:match '^Man' then
      return true
    end
  end
  return false
end

local skip_session = is_git_editor() or is_manpager()

require('persisted').setup {
  autostart = not skip_session,
  autoload = not skip_session,
  use_git_branch = true,
  allowed_dirs = local_config.persisted_allowed_dirs,
  should_autosave = function()
    local ft = vim.bo.filetype
    if ft == 'alpha' or ft == 'man' or ft == 'gitcommit' or ft == 'gitrebase' then
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
