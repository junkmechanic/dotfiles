local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'

dashboard.section.buttons.val = {
  dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
  dashboard.button('m', 'פּ  File Tree', ':NvimTreeOpen <CR>'),
  dashboard.button('d', '  Diff View', ':DiffviewOpen <CR>'),
  dashboard.button('p', '  Open file', ':Telescope find_files <CR>'),
  dashboard.button('n', '  Recently used files', ':Telescope frecency <CR>'),
  dashboard.button('g', '  Search text', ':Telescope live_grep <CR>'),
  dashboard.button('s', '  Open Session', ':SessionLoad <CR>'),
  dashboard.button('z', '  Shell Config', ':e ~/.zshrc<CR>'),
  dashboard.button('t', '  Tmux Config', ':e ~/.tmux.conf<CR>'),
  dashboard.button('q', '  Quit Neovim', ':qa<CR>'),
}

local function footer()
  -- Number of plugins
  local total_plugins = #vim.tbl_keys(packer_plugins)
  local plugins_text = '   '
    .. total_plugins
    .. ' plugins'
    .. '   v'
    .. vim.version().major
    .. '.'
    .. vim.version().minor
    .. '.'
    .. vim.version().patch

  -- Quote
  local fortune = require 'alpha.fortune'
  local quote = table.concat(fortune(), '\n')

  return plugins_text .. '\n' .. quote
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = 'Type'
dashboard.section.header.opts.hl = 'Include'
dashboard.section.buttons.opts.hl = 'Keyword'

-- dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)
