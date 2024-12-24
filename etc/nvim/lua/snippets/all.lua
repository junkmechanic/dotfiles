require('luasnip.loaders.from_lua').lazy_load()

-- This is defined in `lua/config/luasnip`
local env = SNIP_ENV

return {
  env.parse('gmail', 'khanna89ankur@gmail.com', {}),
  env.parse('email', 'akhanna@worldremit.com', {}),
  env.s('date', env.p(os.date, '%Y-%m-%d')),
  env.s('time', env.p(os.date, '%H:%M')),
}
