function _G.dd(arg)
  local res = vim.inspect(arg)
  local ok = pcall(require 'notify', res, 'debug')
  if not ok then
    print(res)
  end
end
