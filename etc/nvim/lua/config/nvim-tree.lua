local function on_attach(bufnr)
  local api = require 'nvim-tree.api'

  local function opts(desc)
    return {
      desc = 'nvim-tree: ' .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  -- Move the cursor outside of nvim-tree before opening a new tab
  local swap_then_open_tab = function()
    local node = api.tree.get_node_under_cursor()
    vim.cmd 'wincmd l'
    api.node.open.tab(node)
  end

  -- Open a new tab silently
  local function open_tab_silent(node)
    api.node.open.tab(node)
    vim.cmd.tabprev()
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.del("n", "<C-e>", { buffer = bufnr })

  vim.keymap.set('n', 's', api.node.open.horizontal, opts 'Open: Horizontal Split')
  vim.keymap.set('n', 'v', api.node.open.vertical, opts 'Open: Vertical Split')
  vim.keymap.set('n', 't', swap_then_open_tab, opts 'Open: New Tab')
  vim.keymap.set('n', 'T', open_tab_silent, opts 'Open Tab Silent')
  vim.keymap.set('n', '<M-c>', api.fs.create, opts 'Create')
end

require('nvim-tree').setup {
  on_attach = on_attach,
  disable_netrw = true,
  view = {
    adaptive_size = true,
  },
  filters = {
    custom = {
      '__pycache__',
    },
  },
  git = {
    ignore = false,
  },
  update_focused_file = {
    enable = true,
  },
  tab = {
    sync = {
      open = true,
      close = true,
    }
  },
}

-- Invocation mapping
vim.keymap.set(
  'n',
  '<LocalLeader>n',
  ':NvimTreeToggle<CR>',
  { noremap = true, silent = true, desc = 'File Tree' }
)
