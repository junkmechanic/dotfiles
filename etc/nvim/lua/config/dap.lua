local dap = require 'dap'
local dapui = require 'dapui'
local widgets = require 'dap.ui.widgets'

local wk = require 'which-key'

-- python adapter setup

require('dap-python').setup '~/.pyenv/versions/py3nvim/bin/python'

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

wk.add {
  { '<LocalLeader>b', group = ' DAP' },
  {
    '<LocalLeader>bB',
    '<Cmd>lua require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")<CR>',
    desc = 'Breakpoint condition',
  },
  { '<LocalLeader>bV', '<Cmd>Telescope dap variables<CR>', desc = 'Variables' },
  { '<LocalLeader>bb', dap.toggle_breakpoint, desc = 'Toggle Breakpoint' },
  { '<LocalLeader>bc', '<Cmd>Telescope dap commands<CR>', desc = 'Commands' },
  { '<LocalLeader>bd', dapui.toggle, desc = 'Toggle DAP-UI' },
  { '<LocalLeader>be', dapui.eval, desc = 'Eval' },
  { '<LocalLeader>bf', '<Cmd>Telescope dap frames<CR>', desc = 'Frames' },
  { '<LocalLeader>bg', '<Cmd>Telescope dap configurations<CR>', desc = 'Configurations' },
  { '<LocalLeader>bh', widgets.hover, desc = 'Hover' },
  { '<LocalLeader>bi', dap.step_into, desc = 'Step Into' },
  { '<LocalLeader>bl', '<Cmd>Telescope dap list_breakpoints<CR>', desc = 'Breakpoints' },
  { '<LocalLeader>bn', dap.step_over, desc = 'Step Over' },
  { '<LocalLeader>bo', dap.step_out, desc = 'Step Out' },
  { '<LocalLeader>bp', dap.repl.toggle, desc = 'Toggle REPL' },
  { '<LocalLeader>br', dap.run_to_cursor, desc = 'Run to Cursor' },
  { '<LocalLeader>bs', dap.continue, desc = 'Continue' },
  {
    '<LocalLeader>bv',
    '<Cmd>lua require("osv").launch({port = 8086})<CR>',
    desc = 'Start OSV',
  },
  { '<LocalLeader>bx', dap.terminate, desc = 'Close Debugger' },
}
