local local_config = require 'config.local-config'
local noice = require 'noice'

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
  local space_indent_cnt =
    vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
  local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
  if space_indent_cnt > tab_indent_cnt then
    return 'MI:' .. tab_indent
  else
    return 'MI:' .. space_indent
  end
end

local function show_persisted()
  if vim.g.persisting then
    return '󰒓'
  elseif not vim.g.persisting then
    return ''
  end
end

local function split(input, delimiter)
  local arr = {}
  local _ = string.gsub(input, '[^' .. delimiter .. ']+', function(w)
    table.insert(arr, w)
  end)
  return arr
end

local function get_python_venv()
  local venv = vim.env.VIRTUAL_ENV
  if venv then
    local params = split(venv, '/')
    return ' 󰌠 ' .. params[#params]
  else
    return ''
  end
end

local symbols = {
  modified = ' ',
  readonly = ' ',
  unnamed = ' ',
  newfile = ' ',
}

-- Patch: when the active window is in disabled_filetypes, buffers/init.lua's
-- update_status injects it back as a fallback "current" entry (current == -2
-- branch), bypassing should_hide. Override update_status on the Windows class
-- to short-circuit that path and render all visible non-hidden windows as inactive.
local Windows = require 'lualine.components.windows'
local Buffers = require 'lualine.components.buffers'
function Windows:update_status()
  if self:should_hide(vim.api.nvim_get_current_win()) then
    local bufs = self:buffers()
    if #bufs == 0 then
      return ''
    end
    local max_length = self.options.max_length
    if type(max_length) == 'function' then
      max_length = max_length(self)
    end
    if max_length == 0 then
      max_length = math.floor(2 * vim.o.columns / 3)
    end
    if bufs[1] then
      bufs[1].first = true
    end
    if bufs[#bufs] then
      bufs[#bufs].last = true
    end
    local data, total_length = {}, 0
    for _, buf in ipairs(bufs) do
      local rendered = buf:render()
      total_length = total_length + buf.len
      if total_length > max_length then
        break
      end
      data[#data + 1] = rendered
    end
    return table.concat(data)
  end
  return Buffers.update_status(self)
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
    lualine_b = {
      'branch',
      'diff',
      'diagnostics',
      {
        noice.api.statusline.mode.get,
        cond = function()
          return vim.fn.reg_recording() ~= ''
        end,
      },
    },
    lualine_c = { { 'filename', symbols = symbols } },
    lualine_x = { get_python_venv, 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress', 'location' },
    lualine_z = { show_trailing_whitespace, show_mixed_indent },
  },
  inactive_sections = {
    lualine_c = { { 'filename', symbols = symbols } },
    lualine_x = {},
  },
  tabline = {
    lualine_a = { { 'tabs', mode = 0 } },
    lualine_b = { { 'windows', symbols = symbols, disabled_filetypes = { 'NvimTree' } } },
    lualine_y = { show_persisted },
  },
  extensions = {
    'fugitive',
    'man',
    'mason',
    'nvim-dap-ui',
    'nvim-tree',
    'oil',
    'quickfix',
    'symbols-outline',
    'toggleterm',
    'trouble',
  },
}
