local goto_preview = require 'goto-preview'
local builtin = require 'telescope.builtin'

local servers = {
  'bashls',
  'cmake',
  'dockerls',
  'jsonls',
  'kotlin_language_server',
  'lua_ls',
  'marksman',
  'pyright',
  'sqlls',
  'terraformls',
  'yamlls',
  'vimls',
}

-- Set up mason-lspconfig before lsp itself.
-- automatic_enable defaults on and enables every mason-installed server it knows,
-- regardless of the list above. Both of these ship an LSP mode but are installed
-- here purely as conform formatters, so keep them out of it.
require('mason-lspconfig').setup {
  ensure_installed = servers,
  automatic_enable = { exclude = { 'ruff', 'stylua' } },
}

-- global diagnostics options
vim.diagnostic.config { virtual_text = false }

-- diagnostics symbols
local signs = { Error = '󰅚 ', Warn = ' ', Hint = '󰛩 ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Neovim's own python provider. Unrelated to any language server, so it must not
-- depend on one having started.
vim.g.python3_host_prog = vim.fn.expand '~/.pyenv/versions/pyglobal/bin/python'

-- root_dir is nil for files with no .git ancestor, so it is checked rather than
-- indexed, and the virtualenv is tried first since it does not need a root at all
local function get_python_path(root_dir)
  local Path = require 'plenary.path'

  -- Use activated virtualenv
  if vim.env.VIRTUAL_ENV then
    return tostring(Path:new(vim.env.VIRTUAL_ENV):joinpath('bin', 'python'))
  end

  if root_dir then
    local venv = Path:new((root_dir:gsub('/', Path.path.sep)), '.venv')
    if venv:joinpath('bin'):is_dir() then
      return tostring(venv:joinpath('bin', 'python'))
    end
  end

  -- Fallback to system Python.
  return vim.fn.exepath 'python3' or vim.fn.exepath 'python'
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Global config for all servers
vim.lsp.config('*', {
  capabilities = capabilities,
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1]))
  end,
})

-- pyright-specific config
vim.lsp.config('pyright', {
  before_init = function(_, config)
    config.settings.python.pythonPath = get_python_path(config.root_dir)
  end,
})

-- lua_ls-specific config
vim.lsp.config('lua_ls', {
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
})

-- kotlin_language_server needs to find Gradle/Maven build files to sync the classpath;
-- the global root_dir (which only looks for .git) is too coarse for multi-module repos.
vim.lsp.config('kotlin_language_server', {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.fs.dirname(vim.fs.find({
      'settings.gradle.kts',
      'settings.gradle',
      'build.gradle.kts',
      'build.gradle',
      'pom.xml',
    }, { path = fname, upward = true })[1])
    if not root then
      root = vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
    end
    on_dir(root)
  end,
  -- Give the JVM more heap; the default is too small for large multi-module projects.
  cmd_env = { KOTLIN_LANGUAGE_SERVER_OPTS = '-Xmx4g' },
  init_options = {
    storagePath = (function()
      local p = vim.fn.expand '~/.cache/kotlin-language-server'
      vim.fn.mkdir(p, 'p')
      return p
    end)(),
  },
})

vim.lsp.enable(servers)

-- Highlight symbol under cursor and clear on move
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- kotlin_language_server crashes (upstream bug) when documentHighlight is called on
    -- files containing local class definitions; skip to avoid JVM OOM cascade.
    if
      client
      and client.name ~= 'kotlin_language_server'
      and client:supports_method 'textDocument/documentHighlight'
    then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = args.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = args.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

-- LSP Mappings

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map('n', '[d', function()
  vim.diagnostic.jump { count = -1 }
end, 'Previous LSP Diagnostics Hunk')
map('n', ']d', function()
  vim.diagnostic.jump { count = 1 }
end, 'Next LSP Diagnostics Hunk')
map('n', 'gt', vim.diagnostic.open_float, 'Show LSP Diagnostics')
map('n', 'gr', vim.lsp.buf.rename, 'LSP Rename')

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
-- <LocalLeader>df mapping in conform config

-- telescope specific mappings
map('n', '<LocalLeader>dd', function()
  builtin.diagnostics()
end, 'Search Project Diagnostics')
map('n', '<LocalLeader>dr', function()
  builtin.lsp_references()
end, 'Search LSP References')

-- goto-preview mappings
map('n', '<LocalLeader>dpd', goto_preview.goto_preview_definition, 'Definition')
map('n', '<LocalLeader>dpr', goto_preview.goto_preview_references, 'References')
map('n', '<LocalLeader>dpx', goto_preview.close_all_win, 'Close All Windows')
map('n', '<LocalLeader>dpi', goto_preview.goto_preview_implementation, 'Implementation')
map('n', '<LocalLeader>dpt', goto_preview.goto_preview_type_definition, 'Type Definition')
