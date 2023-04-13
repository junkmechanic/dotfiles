local M = {
  persisted_allowed_dirs = {
    '~/.files',
    '~/.files/etc/home/nvim',
    '~/devbench/personal/spotifz',
    '~/devbench/personal/algotrading/freqtrade',
  },
}

local env_machine = os.getenv 'MACHINE'
if env_machine == 'work' then
  M.lualine_component_separators = { left = '', right = '' }
  M.lualine_section_separators = { left = '', right = '' }
else
  M.lualine_component_separators = { left = '', right = '' }
  M.lualine_section_separators = { left = '', right = '' }
end

return M
