require("nvim-lsp-installer").setup {
  automatic_installation = true
}

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<LocalLeader>dq', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<LocalLeader>dt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<LocalLeader>dr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<LocalLeader>ca', vim.lsp.buf.code_action, bufopts)
end

local lspconfig = require("lspconfig")

local util = require('lspconfig.util')

local path = util.path

local function get_python_path()

  -- Set python provider virtualenv
  vim.cmd[[
    let g:python3_host_prog =  "~/.pyenv/versions/py3nvim/bin/python"
  ]]

  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Fallback to system Python.
  return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end

lspconfig.pyright.setup {
  on_attach = on_attach,
  before_init = function(_, config)
    config.settings.python.pythonPath = get_python_path()
  end
}
lspconfig.bashls.setup {
  on_attach = on_attach,
}
lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        -- Workaround for packer `use` keyword
        globals = {'vim', 'use'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    }
  }
}
