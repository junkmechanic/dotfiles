local servers = {
  'bashls',
  'cmake',
  'dockerls',
  'jsonls',
  'marksman',
  'pyright',
  'sumneko_lua',
  'sqlls',
  'terraformls',
  'yamlls',
  'vimls',
}

-- Set up mason-lspconfig before lsp itself
require('mason-lspconfig').setup {
  ensure_installed = servers,
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

local options = {
  mode = 'n',
}

local mappings = {
  ['gt'] = { vim.diagnostic.open_float, 'Show LSP Diagnostics' },
  ['[d'] = { vim.diagnostic.goto_prev, 'Previous LSP Diagnostics Hunk' },
  [']d'] = { vim.diagnostic.goto_next, 'Next LSP Diagnostics Hunk' },

  ['<LocalLeader>'] = {
    d = {
      name = ' LSP Diagnostics',

      -- See `:help vim.lsp.*` for documentation on any of the below functions
      a = { vim.lsp.buf.code_action, 'Code Actions' },
      i = { vim.lsp.buf.hover, 'LSP Info for Cursor-word' },
      s = { vim.lsp.buf.signature_help, 'Signature Display' },
      f = { '<Cmd>lua vim.lsp.buf.format({async=true})<CR>', 'Format Buffer' },
      g = { '<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>', 'Goto Definition (vsplit)' },
      G = { '<Cmd>tab split | lua vim.lsp.buf.definition()<CR>', 'Goto Definition (tabnew)' },
      t = { '<Cmd>vsplit | lua vim.lsp.buf.type_definition()<CR>', 'Goto Type Definition (vsplit)' },
      T = { '<Cmd>tab split | lua vim.lsp.buf.type_definition()<CR>', 'Goto Type Definition (tabnew)' },
      d = { '<Cmd>Telescope diagnostics<CR>', 'Search Project Diagnostics' },
      r = { '<Cmd>Telescope lsp_references<CR>', 'Search LSP References' },
      q = { '<Cmd>Trouble document_diagnostics<CR>', 'List Document Diagnostics' },
      w = { '<Cmd>Trouble workspace_diagnostics<CR>', 'List Workspace Diagnostics' },
    },
  },
}

wk.register(mappings, options)

local navic = require 'nvim-navic'

local on_attach = function(client, bufnr)
  -- initiate navic for supported lsp servers
  if client.name ~= 'bashls' and client.name ~= 'dockerls' and client.name ~= 'sqlls' then
    navic.attach(client, bufnr)
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
local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
