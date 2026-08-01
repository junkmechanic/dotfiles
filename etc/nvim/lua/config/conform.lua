local conform = require 'conform'

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
    -- No --dialect: it outranks a project's own .sqlfluff. The default lives in
    -- ~/.sqlfluff instead. require_cwd would skip files with no .sqlfluff above them.
    sqlfluff = {
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
