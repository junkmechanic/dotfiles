require('persisted').setup {
  use_git_branch = true,
  allowed_dirs = {
    '~/.files',
    '~/.files/etc/home/nvim',
    '~/devbench/main/data-fraud/feature-store',
    '~/devbench/main/data-transformations',
    '~/devbench/main/data-ml-pipelines',
    '~/devbench/main/data-ingestions',
  },
}
