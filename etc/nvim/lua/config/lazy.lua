-- Setup lazy.nvim
require('lazy').setup {
  spec = {
    { import = 'plugins' },
  },
  install = { colorscheme = { 'nordfox' } },
  checker = { enabled = true },
  change_detection = {
    notify = false,
  },
}

vim.keymap.set('n', '<LocalLeader>a', function()
  require('lazy').home()
end, { noremap = true, silent = true, desc = 'Lazy Home' })
