require('trouble').setup {
  win = {
    wo = {
      colorcolumn = '',
    },
  },
}

-- nil = off, 'document' = buf-scoped, 'workspace' = all buffers
vim.g.trouble_active_mode = nil

local function open_trouble(mode)
  local opts = { mode = 'diagnostics' }
  if mode == 'document' then
    opts.filter = { buf = 0 }
  end
  require('trouble').open(opts)
  vim.g.trouble_active_mode = mode
end

local function close_trouble()
  require('trouble').close { mode = 'diagnostics' }
  vim.g.trouble_active_mode = nil
end

local function trouble_open_in_tab()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_get_option_value('filetype', { buf = buf }) == 'trouble' then
      return true
    end
  end
  return false
end

vim.api.nvim_create_autocmd('TabEnter', {
  callback = function()
    local mode = vim.g.trouble_active_mode
    if mode then
      vim.schedule(function()
        if not trouble_open_in_tab() then
          close_trouble()
          open_trouble(mode)
        end
      end)
    end
  end,
})

local function map(lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map('<LocalLeader>dq', function()
  if trouble_open_in_tab() then
    close_trouble()
  else
    open_trouble 'document'
  end
end, 'List Document Diagnostics')

map('<LocalLeader>dw', function()
  if trouble_open_in_tab() then
    close_trouble()
  else
    open_trouble 'workspace'
  end
end, 'List Workspace Diagnostics')
