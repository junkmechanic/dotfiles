local luasnip = require 'luasnip'

local source_icons = {
  lsp = '',
  snippets = '',
  path = '󰝰',
  buffer = '󰧮',
  ripgrep = '󰈞',
  spell = '󰓆',
  tmux = '',
  clhistory = '󰋚',
}

require('blink.cmp').setup {
  snippets = { preset = 'luasnip' },
  keymap = {
    preset = 'none',
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback' },
    ['<C-n>'] = { 'select_next', 'fallback' },
    ['<C-c>'] = { 'cancel', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = {
      'select_next',
      function()
        if luasnip.expandable() then
          vim.schedule(luasnip.expand)
          return true
        end
      end,
      'snippet_forward',
      'fallback',
    },
    ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
  },
  completion = {
    list = {
      selection = { preselect = false, auto_insert = true },
    },
    menu = {
      winblend = 10,
      draw = {
        columns = {
          { 'kind_icon' },
          { 'label', 'label_description', gap = 1 },
          { 'source_icon' },
        },
        components = {
          source_icon = {
            text = function(ctx)
              return source_icons[ctx.source_id] or ctx.source_name
            end,
            highlight = 'BlinkCmpSource',
          },
        },
      },
    },
    documentation = {
      auto_show = true,
      window = { winblend = 15 },
    },
    ghost_text = { enabled = false },
  },
  signature = { enabled = true },
  sources = {
    default = { 'snippets', 'lsp', 'path', 'buffer', 'ripgrep', 'tmux', 'spell' },
    providers = {
      buffer = { min_keyword_length = 5 },
      tmux = {
        module = 'blink-cmp-tmux',
        name = 'tmux',
        min_keyword_length = 5,
      },
      clhistory = {
        module = 'cmdlinehistory',
        name = 'History',
      },
      ripgrep = {
        module = 'blink-ripgrep',
        name = 'Ripgrep',
        min_keyword_length = 5,
      },
      spell = {
        module = 'blink-cmp-spell',
        name = 'Spell',
        min_keyword_length = 5,
      },
    },
  },
  cmdline = {
    sources = function()
      local type = vim.fn.getcmdtype()
      if type == '/' or type == '?' then
        return { 'buffer', 'clhistory' }
      elseif type == ':' or type == '@' then
        return { 'cmdline', 'clhistory' }
      end
      return {}
    end,
    keymap = {
      preset = 'cmdline',
      ['<CR>'] = { 'accept', 'fallback' },
    },
    completion = { menu = { auto_show = true } },
  },
}
