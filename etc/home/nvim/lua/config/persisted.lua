local local_config = require 'config.local-config'

require('persisted').setup {
  use_git_branch = true,
  allowed_dirs = local_config.persisted_allowed_dirs,
}
