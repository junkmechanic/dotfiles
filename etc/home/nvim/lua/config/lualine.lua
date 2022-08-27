local navic = require 'nvim-navic'

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics', 'filename' },
    lualine_c = {},
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = {
      'location',
      function()
        local space = vim.fn.search([[\s\+$]], 'nwc')
        return space ~= 0 and 'TW:' .. space or ''
      end,
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_d = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = { { 'tabs', mode = 0 } },
    lualine_b = { 'windows' },
    lualine_x = { { navic.get_location, cond = navic.is_available } },
  },
  extensions = {
    'quickfix',
    'nvim-tree',
  },
}
