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
      V = { '<Cmd>Telescope dap variables<CR>', 'Variables' },

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

      v = { '<Cmd>lua require("osv").launch({port = 8086})<CR>', 'Start OSV' },
      B = {
        '<Cmd>lua require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")<CR>',
        'Breakpoint condition',
      },
    },
  },
}

wk.register(mappings, options)
