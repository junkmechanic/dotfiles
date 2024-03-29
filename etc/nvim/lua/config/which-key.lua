local wk = require 'which-key'

wk.setup {
  plugins = {
    marks = false,
    spelling = {
      enabled = true,
    },
  },
  key_labels = {
    ['`'] = '<LocalLeader>',
    ['<leader>'] = '<Leader>',
    ['<cr>'] = '<CR>',
    ['<tab>'] = '<Tab>',
  },
  window = {
    winblend = 20,
  },
  layout = {
    height = { min = 5, max = 25 },
    spacing = 5,
    align = 'center',
  },
}

local options = {
  mode = 'n',
}

local mappings = {
  g = {
    r = 'Smart Rename',
  },
  ['<Leader>'] = {
    b = 'Swap Master Node with next',
    B = 'Swap Master Node with previous',
    w = 'Swap Current Node with next',
    W = 'Swap Current Node with previous',
  },
  ['<LocalLeader>'] = {
    w = 'Window Management',
    z = 'Horizontal Scrolling',
  },
}

wk.register(mappings, options)
