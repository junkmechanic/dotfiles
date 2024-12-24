local cmp = require 'cmp'
local lspkind = require 'lspkind'
local luasnip = require 'luasnip'
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format {
      maxwidth = 50,
      mode = 'symbol',
      menu = {
        nvim_lsp = '',
        nvim_lua = '',
        treesitter = '',
        path = '󰝰',
        buffer = '󰧮',
        rg = '󰈞',
        spell = '󰓆',
        calc = '󰃬',
        luasnip = '',
      },
    },
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-c>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'treesitter' },
    { name = 'nvim_lua' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'buffer', keyword_length = 5 },
    { name = 'rg', keyword_length = 5 },
    { name = 'path' },
    { name = 'spell', keyword_length = 5 },
    { name = 'calc' },
  },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
    { name = 'cmdline_history' },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
    { name = 'cmdline_history' },
  }),
})

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
