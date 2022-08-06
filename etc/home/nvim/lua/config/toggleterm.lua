require("toggleterm").setup{
  open_mapping = [[<C-\>]],
  start_in_insert = true,
  direction = 'float',
  close_on_exit = true,
  auto_scroll = true,
  float_opts = {
    border = 'single',
    winblend = 10,
  },
  winbar = {
    enabled = false,
  },
}
