require("nvim-lsp-installer").setup {
  automatic_installation = true
}

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<LocalLeader>dq', vim.diagnostic.setloclist, opts)

local navic = require("nvim-navic")

local on_attach = function(client, bufnr)
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', "<Cmd>tab split | lua vim.lsp.buf.definition()<CR>", bufopts)
  vim.keymap.set('n', '<LocalLeader>dt', "<Cmd>vsplit | lua vim.lsp.buf.type_definition()<CR>", bufopts)
  vim.keymap.set('n', '<LocalLeader>di', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<LocalLeader>ds', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<LocalLeader>dr', vim.lsp.buf.references, bufopts)
  navic.attach(client, bufnr)
end

local lspconfig = require("lspconfig")
local util = require('lspconfig.util')
local path = util.path

local function get_python_path()
  -- Set python provider virtualenv
  vim.cmd[[
    let g:python3_host_prog = "~/.pyenv/versions/py3nvim/bin/python"
  ]]
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end
  -- Fallback to system Python.
  return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = {
 "bashls",
 "dockerls",
 "jsonls",
 "pyright",
 "sumneko_lua",
 "terraformls",
 "yamlls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    before_init = function(_, config)
      if lsp == "pyright" then
        config.settings.python.pythonPath = get_python_path()
      end
    end,
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
end
