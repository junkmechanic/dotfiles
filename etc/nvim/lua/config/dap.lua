local dap = require 'dap'
local dapui = require 'dapui'
local widgets = require 'dap.ui.widgets'

local wk = require 'which-key'

require('dap-python').setup '~/.pyenv/versions/3.9.0/envs/py3nvim/bin/python'

-- bash adapter config

dap.adapters.bashdb = {
  type = 'executable',
  command = vim.fn.stdpath 'data' .. '/mason/packages/bash-debug-adapter/bash-debug-adapter',
  name = 'bashdb',
}

dap.configurations.sh = {
  {
    type = 'bashdb',
    request = 'launch',
    name = 'Launch file',
    showDebugOutput = true,
    pathBashdb = vim.fn.stdpath 'data' .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
    pathBashdbLib = vim.fn.stdpath 'data' .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
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

local options = {
  mode = 'n',
}

local mappings = {
  ['<LocalLeader>'] = {
    b = {
      name = ' DAP',
      c = { '<Cmd>Telescope dap commands<CR>', 'Commands' },
      f = { '<Cmd>Telescope dap frames<CR>', 'Frames' },
      g = { '<Cmd>Telescope dap configurations<CR>', 'Configurations' },
      l = { '<Cmd>Telescope dap list_breakpoints<CR>', 'Breakpoints' },
      v = { '<Cmd>Telescope dap variables<CR>', 'Variables' },
      b = { dap.toggle_breakpoint, 'Toggle Breakpoint' },
      d = { dapui.toggle, 'Toggle DAP-UI' },
      e = { dapui.eval, 'Eval' },
      h = { widgets.hover, 'Hover' },
      i = { dap.step_into, 'Step Into' },
      n = { dap.step_over, 'Step Over' },
      o = { dap.step_out, 'Step Out' },
      p = { dap.repl.toggle, 'Toggle REPL' },
      r = { dap.run_to_cursor, 'Run to Cursor' },
      s = { dap.continue, 'Continue' },
      x = { dap.terminate, 'Close Debugger' },
    },
  },
}

wk.register(mappings, options)
