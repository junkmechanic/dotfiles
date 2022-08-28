local navic = require 'nvim-navic'
local local_config = require 'config.local-config'

local function show_trailing_whitespace()
  local space = vim.fn.search([[\s\+$]], 'nwc')
  return space ~= 0 and 'TW:' .. space or ''
end

local function show_mixed_indent()
  local space_pat = [[\v^ +]]
  local tab_pat = [[\v^\t+]]
  local space_indent = vim.fn.search(space_pat, 'nwc')
  local tab_indent = vim.fn.search(tab_pat, 'nwc')
  local mixed = (space_indent > 0 and tab_indent > 0)
  local mixed_same_line
  if not mixed then
    mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
    mixed = mixed_same_line > 0
  end
  if not mixed then
    return ''
  end
  if mixed_same_line ~= nil and mixed_same_line > 0 then
    return 'MI:' .. mixed_same_line
  end
  local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
  local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
  if space_indent_cnt > tab_indent_cnt then
    return 'MI:' .. tab_indent
  else
    return 'MI:' .. space_indent
  end
end

local function show_persisted()
  if vim.g.persisting then
    return ''
  elseif not vim.g.persisting then
    return ''
  end
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = local_config.lualine_component_separators,
    section_separators = local_config.lualine_section_separators,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics', 'filename' },
    lualine_c = { { navic.get_location, cond = navic.is_available } },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location', show_trailing_whitespace, show_mixed_indent },
  },
  inactive_sections = {
    lualine_b = { 'filename' },
    lualine_c = {},
    lualine_x = {},
  },
  tabline = {
    lualine_a = { { 'tabs', mode = 0 } },
    lualine_b = { 'windows' },
    lualine_y = { show_persisted },
  },
  extensions = {
    'quickfix',
    'nvim-tree',
  },
}
