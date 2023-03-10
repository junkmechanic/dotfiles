vim.o.sessionoptions =
  'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

require('auto-session').setup {
  auto_session_enabled = false,
  auto_session_create_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = false,
  auto_session_use_git_branch = true,
}
