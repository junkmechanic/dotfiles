require('neo-tree').setup {
  close_if_last_window = true,
  sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
  default_component_configs = {
    file_size = { enabled = true },
    type = { enabled = false },
    last_modified = { enabled = false },
    created = { enabled = false },
  },
  window = {
    width = 35,
    auto_expand_width = true,
    mappings = {
      ['<C-e>'] = 'none',
      ['s'] = 'open_split',
      ['v'] = 'open_vsplit',
      ['t'] = 'open_tabnew',
      ['T'] = function(state)
        local node = state.tree:get_node()
        if node.type == 'file' then
          vim.cmd('tabnew ' .. vim.fn.fnameescape(node.path))
          vim.cmd.tabprev()
        end
      end,
      ['<M-c>'] = 'add',
    },
  },
  filesystem = {
    filtered_items = {
      hide_gitignored = false,
      never_show = { '__pycache__' },
    },
    follow_current_file = { enabled = true },
    hijack_netrw_behavior = 'open_default',
  },
  event_handlers = {
    {
      event = 'neo_tree_window_after_open',
      handler = function()
        vim.cmd 'wincmd ='
      end,
    },
    {
      event = 'neo_tree_window_after_close',
      handler = function()
        vim.cmd 'wincmd ='
      end,
    },
  },
}

-- Tab sync: reopen neo-tree in every tab when switching, if it's enabled
vim.g.neo_tree_enabled = false

vim.api.nvim_create_autocmd('TabEnter', {
  callback = function()
    if not vim.g.neo_tree_enabled then
      return
    end
    vim.schedule(function()
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == 'neo-tree' then
          return
        end
      end
      vim.cmd 'Neotree show'
    end)
  end,
})

-- Allow horizontal scrolling in the neo-tree sidebar
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'neo-tree',
  callback = function()
    vim.opt_local.sidescrolloff = 0
  end,
})

vim.keymap.set('n', '<LocalLeader>n', function()
  if vim.g.neo_tree_enabled then
    vim.g.neo_tree_enabled = false
    for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
        if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == 'neo-tree' then
          vim.api.nvim_win_close(win, false)
        end
      end
    end
  else
    vim.g.neo_tree_enabled = true
    vim.cmd 'Neotree show'
  end
end, { noremap = true, silent = true, desc = 'File Tree' })

vim.keymap.set(
  'n',
  '<LocalLeader>o',
  ':Neotree source=document_symbols toggle<CR>',
  { noremap = true, silent = true, desc = 'Document Symbols' }
)
