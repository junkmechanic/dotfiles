vim.filetype.add {
  pattern = {
    ['requirements*.txt'] = 'config',
  },
}

function _G.debug_notif(arg)
  local res = vim.inspect(arg)
  local ok = pcall(require 'notify', res)
  if not ok then
    vim.notify(res)
  end
end
