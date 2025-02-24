local dap = require 'dap'
local dapui = require 'dapui'
local widgets = require 'dap.ui.widgets'

-- python adapter setup

require('dap-python').setup '~/.pyenv/versions/pyglobal/bin/python'

local configurations = require('dap').configurations.python
-- `justMyCode` is valid for launch confgiurations only
configurations[1].justMyCode = false
configurations[2].justMyCode = false

-- bash adapter setup

dap.adapters.bashdb = {
  type = 'executable',
  command = vim.fn.stdpath 'data'
    .. '/mason/packages/bash-debug-adapter/bash-debug-adapter',
  name = 'bashdb',
}

dap.configurations.sh = {
  {
    type = 'bashdb',
    request = 'launch',
    name = 'Launch file',
    showDebugOutput = true,
    pathBashdb = vim.fn.stdpath 'data'
      .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
    pathBashdbLib = vim.fn.stdpath 'data'
      .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
    trace = true,
    file = '${file}',
    program = '${file}',
    cwd = '${workspaceFolder}',
    pathCat = 'cat',
    pathBash = '/usr/local/bin/bash',
    pathMkfifo = 'mkfifo',
    pathPkill = 'pkill',
    args = {},
    env = {},
    terminalKind = 'integrated',
  },
}

-- nvim lua adapter setup

dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = 'Attach to running Neovim instance',
  },
}

dap.adapters.nlua = function(callback, config)
  callback {
    type = 'server',
    host = config.host or '127.0.0.1',
    port = config.port or 8086,
  }
end

-- DAP-UI Setup

dapui.setup()

--  Launch DAP-UI on a new debugging session
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open {}
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close {}
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close {}
end

-- Mappings

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map(
  'n',
  '<LocalLeader>bB',
  '<Cmd>lua require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")<CR>',
  'Breakpoint condition'
)
map('n', '<LocalLeader>bV', '<Cmd>Telescope dap variables<CR>', 'Variables')
map('n', '<LocalLeader>bb', dap.toggle_breakpoint, 'Toggle Breakpoint')
map('n', '<LocalLeader>bc', '<Cmd>Telescope dap commands<CR>', 'Commands')
map('n', '<LocalLeader>bd', dapui.toggle, 'Toggle DAP-UI')
map('n', '<LocalLeader>be', dapui.eval, 'Eval')
map('n', '<LocalLeader>bf', '<Cmd>Telescope dap frames<CR>', 'Frames')
map('n', '<LocalLeader>bg', '<Cmd>Telescope dap configurations<CR>', 'Configurations')
map('n', '<LocalLeader>bh', widgets.hover, 'Hover')
map('n', '<LocalLeader>bi', dap.step_into, 'Step Into')
map('n', '<LocalLeader>bl', '<Cmd>Telescope dap list_breakpoints<CR>', 'Breakpoints')
map('n', '<LocalLeader>bn', dap.step_over, 'Step Over')
map('n', '<LocalLeader>bo', dap.step_out, 'Step Out')
map('n', '<LocalLeader>bp', dap.repl.toggle, 'Toggle REPL')
map('n', '<LocalLeader>br', dap.run_to_cursor, 'Run to Cursor')
map('n', '<LocalLeader>bs', dap.continue, 'Continue')
map(
  'n',
  '<LocalLeader>bv',
  '<Cmd>lua require("osv").launch({port = 8086})<CR>',
  'Start OSV'
)
map('n', '<LocalLeader>bx', dap.terminate, 'Close Debugger')
