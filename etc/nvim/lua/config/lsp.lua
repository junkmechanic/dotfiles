local goto_preview = require 'goto-preview'
local builtin = require 'telescope.builtin'

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

-- global diagnostics options
vim.diagnostic.config { virtual_text = false }

-- diagnostics symbols
local signs = { Error = '󰅚 ', Warn = ' ', Hint = '󰛩 ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local lspconfig = require 'lspconfig'

local function get_python_path(config)
  local Path = require 'plenary.path'
  local venv = Path:new((config.root_dir:gsub('/', Path.path.sep)), '.venv')

  -- Set python provider virtualenv
  vim.cmd [[
    let g:python3_host_prog = '~/.pyenv/versions/py3nvim/bin/python'
  ]]

  -- Use activated virtualenv
  if vim.env.VIRTUAL_ENV then
    return tostring(Path:new(vim.env.VIRTUAL_ENV):joinpath('bin', 'python'))
  elseif venv:joinpath('bin'):is_dir() then
    return tostring(venv:joinpath('bin', 'python'))
  end
  -- Fallback to system Python.
  return vim.fn.exepath 'python3' or vim.fn.exepath 'python'
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, lsp_server in ipairs(servers) do
  lspconfig[lsp_server].setup {
    capabilities = capabilities,
    before_init = function(_, config)
      if lsp_server == 'pyright' then
        config.settings.python.pythonPath = get_python_path(config)
      end
    end,
    root_dir = function(fname)
      return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
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

-- LSP Mappings

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map('n', '[d', vim.diagnostic.goto_prev, 'Previous LSP Diagnostics Hunk')
map('n', ']d', vim.diagnostic.goto_next, 'Next LSP Diagnostics Hunk')
map('n', 'gt', vim.diagnostic.open_float, 'Show LSP Diagnostics')

-- See `:help vim.lsp.*` for documentation on any of the below functions

map('n', '<LocalLeader>da', vim.lsp.buf.code_action, 'Code Actions')
map('n', '<LocalLeader>di', vim.lsp.buf.hover, 'LSP Info for Cursor-word')
map('n', '<LocalLeader>ds', vim.lsp.buf.signature_help, 'Signature Display')

map(
  'n',
  '<LocalLeader>dG',
  '<Cmd>tab split | lua vim.lsp.buf.definition()<CR>',
  'Goto Definition (tabnew)'
)
map(
  'n',
  '<LocalLeader>dg',
  '<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>',
  'Goto Definition (vsplit)'
)

map(
  'n',
  '<LocalLeader>dT',
  '<Cmd>tab split | lua vim.lsp.buf.type_definition()<CR>',
  'Goto Type Definition (tabnew)'
)
map(
  'n',
  '<LocalLeader>dt',
  '<Cmd>vsplit | lua vim.lsp.buf.type_definition()<CR>',
  'Goto Type Definition (vsplit)'
)
map('n', '<LocalLeader>df', function()
  vim.lsp.buf.format { async = true }
end, 'Format Buffer')

-- telescope specific mappings
map('n', '<LocalLeader>dd', function()
  builtin.diagnostics()
end, 'Search Project Diagnostics')
map('n', '<LocalLeader>dr', function()
  builtin.lsp_references()
end, 'Search LSP References')

-- trouble mappings
map(
  'n',
  '<LocalLeader>dq',
  '<Cmd>Trouble diagnostics toggle filter.buf=0<CR>',
  'List Document Diagnostics'
)
map(
  'n',
  '<LocalLeader>dw',
  '<Cmd>Trouble diagnostics toggle<CR>',
  'List Workspace Diagnostics'
)

-- goto-preview mappings
map('n', '<LocalLeader>dpd', goto_preview.goto_preview_definition, 'Definition')
map('n', '<LocalLeader>dpr', goto_preview.goto_preview_references, 'References')
map('n', '<LocalLeader>dpx', goto_preview.close_all_win, 'Close All Windows')
map('n', '<LocalLeader>dpi', goto_preview.goto_preview_implementation, 'Implementation')
map('n', '<LocalLeader>dpt', goto_preview.goto_preview_type_definition, 'Type Definition')
