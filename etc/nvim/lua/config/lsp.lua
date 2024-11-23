local servers = {
  'bashls',
  'cmake',
  'dockerls',
  'jsonls',
  'lua_ls',
  'marksman',
  'pyright',
  'sqlls',
  'terraformls',
  'yamlls',
  'vimls',
}

-- Set up mason-lspconfig before lsp itself
require('mason-lspconfig').setup {
  ensure_installed = servers,
}

local navic = require 'nvim-navic'

local wk = require 'which-key'

-- global diagnostics options
vim.diagnostic.config { virtual_text = false }

-- diagnostics symbols
local signs = { Error = '󰅚 ', Warn = ' ', Hint = '󰛩 ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local on_attach = function(client, bufnr)
  -- initiate navic for supported lsp servers
  local unsupported_servers = { 'bashls', 'dockerls', 'sqlls' }
  if not vim.tbl_contains(unsupported_servers, client.name) then
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

-- goto-preview
local goto_preview = require 'goto-preview'
goto_preview.setup {}

-- LSP Mappings
wk.add {
  { '[d', vim.diagnostic.goto_prev, desc = 'Previous LSP Diagnostics Hunk' },
  { ']d', vim.diagnostic.goto_next, desc = 'Next LSP Diagnostics Hunk' },
  { 'gt', vim.diagnostic.open_float, desc = 'Show LSP Diagnostics' },

  { '<LocalLeader>d', group = ' LSP Diagnostics' },
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  {
    '<LocalLeader>dG',
    '<Cmd>tab split | lua vim.lsp.buf.definition()<CR>',
    desc = 'Goto Definition (tabnew)',
  },
  {
    '<LocalLeader>dT',
    '<Cmd>tab split | lua vim.lsp.buf.type_definition()<CR>',
    desc = 'Goto Type Definition (tabnew)',
  },
  { '<LocalLeader>da', vim.lsp.buf.code_action, desc = 'Code Actions' },
  {
    '<LocalLeader>dd',
    '<Cmd>Telescope diagnostics<CR>',
    desc = 'Search Project Diagnostics',
  },
  {
    '<LocalLeader>df',
    '<Cmd>lua vim.lsp.buf.format({async=true})<CR>',
    desc = 'Format Buffer',
  },
  {
    '<LocalLeader>dg',
    '<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>',
    desc = 'Goto Definition (vsplit)',
  },
  { '<LocalLeader>di', vim.lsp.buf.hover, desc = 'LSP Info for Cursor-word' },
  {
    '<LocalLeader>dq',
    '<Cmd>Trouble document_diagnostics<CR>',
    desc = 'List Document Diagnostics',
  },
  {
    '<LocalLeader>dr',
    '<Cmd>Telescope lsp_references<CR>',
    desc = 'Search LSP References',
  },
  { '<LocalLeader>ds', vim.lsp.buf.signature_help, desc = 'Signature Display' },
  {
    '<LocalLeader>dt',
    '<Cmd>vsplit | lua vim.lsp.buf.type_definition()<CR>',
    desc = 'Goto Type Definition (vsplit)',
  },
  {
    '<LocalLeader>dw',
    '<Cmd>Trouble workspace_diagnostics<CR>',
    desc = 'List Workspace Diagnostics',
  },

  { '<LocalLeader>dp', group = ' Preview' },
  { '<LocalLeader>dpd', goto_preview.goto_preview_definition, desc = 'Definition' },
  {
    '<LocalLeader>dpi',
    goto_preview.goto_preview_implementation,
    desc = 'Implementation',
  },
  { '<LocalLeader>dpr', goto_preview.goto_preview_references, desc = 'References' },
  {
    '<LocalLeader>dpt',
    goto_preview.goto_preview_type_definition,
    desc = 'Type Definition',
  },
  { '<LocalLeader>dpx', goto_preview.close_all_win, desc = 'Close All Windows' },
}
