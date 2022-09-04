require('nvim-lsp-installer').setup {
  automatic_installation = true,
}

local wk = require 'which-key'

-- global diagnostics options
vim.diagnostic.config { virtual_text = false }

-- diagnostics symbols
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'gt', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

-- The mapping for quickfix diagnostics is set in `trouble` config
-- vim.keymap.set('n', '<LocalLeader>dq', vim.diagnostic.setloclist, opts)

local navic = require 'nvim-navic'

local on_attach = function(client, bufnr)
  local options = {
    mode = 'n',
    prefix = '<LocalLeader>',
  }
  local mappings = {
    d = {
      name = ' LSP + Diagnostics',
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      f = { vim.lsp.buf.formatting, 'Format Buffer' },
      a = { vim.lsp.buf.code_action, 'Buffer Code Actions' },
      i = { vim.lsp.buf.hover, 'LSP Info for Cursor-word' },
      s = { vim.lsp.buf.signature_help, 'Signature Display' },
      d = { '<Cmd>Telescope diagnostics<CR>', 'Search Diagnostics' },
      j = { '<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>', 'Goto Definition' },
      t = { '<Cmd>tab split | lua vim.lsp.buf.type_definition()<CR>', 'Goto Type Definition' },
      q = { '<Cmd>Trouble document_diagnostics<CR>', 'List Document Diagnostics' },
    },

    t = { '<Cmd>Trouble workspace_diagnostics<CR>', 'List Workspace Diagnostics' },
  }
  wk.register(mappings, options)

  -- The mapping for listing references is set in the `telescope` config to `<Leader>r`
  -- vim.keymap.set('n', '<LocalLeader>dr', vim.lsp.buf.references, bufopts)

  if client.name ~= 'bashls' and client.name ~= 'dockerls' and client.name ~= 'sqlls' then
    navic.attach(client, bufnr)
  end

  -- Turn off formatting via `sumneko_lua` in favor of `stylua` via `null-ls`
  if client.name == 'sumneko_lua' then
    client.resolved_capabilities.document_formatting = false
  end
end

local lspconfig = require 'lspconfig'
local util = require 'lspconfig.util'
local path = util.path

local function get_python_path()
  -- Set python provider virtualenv
  vim.cmd [[
    let g:python3_host_prog = "~/.pyenv/versions/py3nvim/bin/python"
  ]]
  -- Use activated virtualenv
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end
  -- Fallback to system Python.
  return vim.fn.exepath 'python3' or vim.fn.exepath 'python' or 'python'
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = {
  'bashls',
  'dockerls',
  'jsonls',
  'pyright',
  'sumneko_lua',
  'sqlls',
  'terraformls',
  'yamlls',
  'vimls',
}

for _, lsp_server in ipairs(servers) do
  lspconfig[lsp_server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    before_init = function(_, config)
      if lsp_server == 'pyright' then
        config.settings.python.pythonPath = get_python_path()
      end
    end,
    root_dir = function(fname)
      return util.find_git_ancestor(fname) or vim.fn.getcwd()
    end,
    settings = {
      Lua = {
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          -- This should be maintained in `.luarc.json` in the project dir
          -- globals = { 'vim', 'use' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }
end
