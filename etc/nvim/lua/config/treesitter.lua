require('nvim-treesitter').setup {
  install_dir = vim.fn.stdpath 'data' .. '/site',
}

-- Parsers not bundled with Neovim (c, lua, vim, vimdoc, query, markdown are built-in)
require('nvim-treesitter').install {
  'bash',
  'dockerfile',
  'gitcommit',
  'gitignore',
  'hcl',
  'json',
  'kotlin',
  'make',
  'python',
  'regex',
  'sql',
  'yaml',
}

local ts_hl_disabled = {
  sql = true,
  -- gitcommit = true
}

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    if ts_hl_disabled[vim.bo[args.buf].filetype] then
      return
    end
    local ok = pcall(vim.treesitter.start, args.buf)
    if ok then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- Textobjects (nvim-treesitter-textobjects main branch uses explicit keymaps)
require('nvim-treesitter-textobjects').setup {
  select = { lookahead = true },
}

local ts_select = require 'nvim-treesitter-textobjects.select'
local textobject_maps = {
  ['af'] = { '@function.outer', 'Outer function' },
  ['if'] = { '@function.inner', 'Inner function' },
  ['al'] = { '@loop.outer', 'Outer loop' },
  ['il'] = { '@loop.inner', 'Inner loop' },
  ['ac'] = { '@conditional.outer', 'Outer conditional' },
  ['ic'] = { '@conditional.inner', 'Inner conditional' },
  ['a,'] = { '@parameter.outer', 'Outer parameter' },
  ['i,'] = { '@parameter.inner', 'Inner parameter' },
}

for lhs, spec in pairs(textobject_maps) do
  vim.keymap.set({ 'x', 'o' }, lhs, function()
    ts_select.select_textobject(spec[1], 'textobjects')
  end, { noremap = true, silent = true, desc = spec[2] })
end

require('treesitter-context').setup {}
