local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'

local function button(shortcut, txt, keybind, keybind_opts)
  local opts = {
    position = 'center',
    shortcut = shortcut,
    cursor = 5,
    width = 50,
    align_shortcut = 'right',
    hl_shortcut = 'Keyword',
  }
  if keybind then
    keybind_opts =
      vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
    opts.keymap = { 'n', shortcut, keybind, keybind_opts }
  end

  local function on_press()
    local key = vim.api.nvim_replace_termcodes(shortcut, true, false, true)
    vim.api.nvim_feedkeys(key, 't', false)
  end

  return {
    type = 'button',
    val = txt,
    on_press = on_press,
    opts = opts,
  }
end

dashboard.section.buttons.val = {
  button('e', '  New file', ':ene <CR>'),
  button('i', '  Insert new', ':ene <BAR> startinsert <CR>'),
  button('m', 'פּ  File Tree', ':NvimTreeOpen <CR>'),
  button('d', '  Diff View', ':DiffviewOpen <CR>'),
  button('p', '  Open file', ':Telescope find_files <CR>'),
  button('n', '  Recent files', ':Telescope frecency <CR>'),
  button('g', '  Search text', ':Telescope live_grep <CR>'),
  button('s', '  Open Session', ':SessionLoad <CR>'),
  button('z', '  Shell Config', ':e ~/.zshrc<CR>'),
  button('t', '  Tmux Config', ':e ~/.tmux.conf<CR>'),
  button('q', '  Quit Neovim', ':qa<CR>'),
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

alpha.setup(dashboard.opts)
