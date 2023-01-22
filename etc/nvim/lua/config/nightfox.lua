require('nightfox').setup {
  options = {
    dim_inactive = false,
    styles = {
      comments = 'italic',
    },
  },
}

vim.cmd 'colorscheme nordfox'

local nordfox = require 'nightfox.palette.nordfox'
local palette = nordfox.palette

-- Telescope Theme

vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = palette.black.base, bg = palette.black.base })
vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = palette.black.base })
vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = palette.black.base })
vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { fg = palette.red.base, bg = palette.black.base })
vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = palette.black.base, bg = palette.red.base })
vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = palette.black.base, bg = palette.green.base })
vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = palette.black.base, bg = palette.blue.base })
vim.api.nvim_set_hl(0, 'TelescopeSelection', { fg = palette.blue.base, bg = palette.bg2 })
