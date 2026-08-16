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
  document_symbols = {
    window = {
      -- The document_symbols source has no filesystem commands, so unmap the
      -- ones inherited from the global window mappings -- neo-tree warns about
      -- each unresolved mapping when the source opens.
      mappings = {
        ['<M-c>'] = 'none', -- add
        ['<C-r>'] = 'none', -- clear_clipboard
      },
    },
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

-- Diffview tabs hold `diffview://` buffers; opening neo-tree there makes it
-- `tcd` to that path, which fails with E344 and blocks on a "Press ENTER"
-- prompt.
local function in_diffview_tab()
  local lib = package.loaded['diffview.lib']
  if lib and lib.get_current_view() then
    return true
  end
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if
      vim.bo[buf].filetype:match '^Diffview'
      or vim.api.nvim_buf_get_name(buf):match '^diffview://'
    then
      return true
    end
  end
  return false
end

vim.api.nvim_create_autocmd('TabEnter', {
  callback = function()
    if not vim.g.neo_tree_enabled then
      return
    end
    vim.schedule(function()
      if in_diffview_tab() then
        return
      end
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
    if not in_diffview_tab() then
      vim.cmd 'Neotree show'
    end
  end
end, { noremap = true, silent = true, desc = 'File Tree' })

vim.keymap.set(
  'n',
  '<LocalLeader>o',
  ':Neotree source=document_symbols toggle<CR>',
  { noremap = true, silent = true, desc = 'Document Symbols' }
)
