local M = {}

local env_machine = os.getenv 'MACHINE'
if env_machine == 'work' then
  M.lualine_component_separators = { left = '', right = '' }
  M.lualine_section_separators = { left = '', right = '' }
else
  M.lualine_component_separators = { left = '', right = '' }
  M.lualine_section_separators = { left = '', right = '' }
end

return M
