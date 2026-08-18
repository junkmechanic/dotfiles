local conform = require 'conform'
local python = require 'util.python'

-- Prefer a python tool installed in the project's own virtualenv over mason's copy,
-- so a version pinned in pyproject.toml is the one that formats the buffer and nvim
-- agrees with what CI does. Falls back to mason's when the project has not pinned it.
local function project_tool(name)
  return function(_, ctx)
    return python.bin(name, python.root(ctx.filename)) or name
  end
end

local prettier = { 'prettier' }
local terraform = { 'terraform_fmt' }

conform.setup {
  formatters_by_ft = {
    bash = { 'beautysh' },
    cmake = { 'cmake_format' },
    csh = { 'beautysh' },
    kotlin = { 'ktlint' },
    ksh = { 'beautysh' },
    lua = { 'stylua' },
    luau = { 'stylua' },
    python = { 'ruff_organize_imports', 'ruff_format' },
    sh = { 'shfmt' },
    sql = { 'sqlfluff' },

    terraform = terraform,
    tf = terraform,
    ['terraform-vars'] = terraform,

    astro = prettier,
    css = prettier,
    graphql = prettier,
    handlebars = prettier,
    html = prettier,
    htmlangular = prettier,
    javascript = prettier,
    javascriptreact = prettier,
    json = prettier,
    json5 = prettier,
    jsonc = prettier,
    less = prettier,
    markdown = prettier,
    ['markdown.mdx'] = prettier,
    scss = prettier,
    svelte = prettier,
    typescript = prettier,
    typescriptreact = prettier,
    vue = prettier,
    yaml = prettier,
  },
  formatters = {
    ruff_format = { command = project_tool 'ruff' },
    ruff_organize_imports = { command = project_tool 'ruff' },

    -- No --dialect: it outranks a project's own .sqlfluff. The default lives in
    -- ~/.sqlfluff instead. require_cwd would skip files with no .sqlfluff above them.
    sqlfluff = {
      command = project_tool 'sqlfluff',
      require_cwd = false,
    },
  },
  -- No lsp_format fallback, so only the tools above format on save.
  -- To skip formatting for one write, use ` :noautocmd w `
  format_on_save = {
    timeout_ms = 3000,
  },
}

-- Route `gq` through conform too
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
