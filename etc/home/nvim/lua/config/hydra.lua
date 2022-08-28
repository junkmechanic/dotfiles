local Hydra = require 'hydra'
local splits = require 'smart-splits'

local cmd = require('hydra.keymap-util').cmd
local pcmd = require('hydra.keymap-util').pcmd

Hydra {
  name = 'Side scroll',
  config = {
    invoke_on_body = true,
  },
  mode = 'n',
  body = '<Leader>z',
  heads = {
    { 'h', '5zh' },
    { 'l', '5zl', { desc = '←/→' } },
    { 'H', 'zH' },
    { 'L', 'zL', { desc = 'half screen ←/→' } },
    { '<Esc>', nil, { exit = true, desc = false } },
  },
}

Hydra {
  name = 'Windows',
  config = {
    invoke_on_body = true,
  },
  mode = 'n',
  body = '<C-w>',
  heads = {
    { 'h', '<C-w>h' },
    { 'j', '<C-w>j' },
    { 'k', pcmd('wincmd k', 'E11', 'close') },
    { 'l', '<C-w>l', { desc = 'focus' } },

    { 'H', cmd 'WinShift left' },
    { 'J', cmd 'WinShift down' },
    { 'K', cmd 'WinShift up' },
    { 'L', cmd 'WinShift right', { desc = 'move' } },

    {
      '<C-h>',
      function()
        splits.resize_left(2)
      end,
    },
    {
      '<C-j>',
      function()
        splits.resize_down(2)
      end,
    },
    {
      '<C-k>',
      function()
        splits.resize_up(2)
      end,
    },
    {
      '<C-l>',
      function()
        splits.resize_right(2)
      end,
      { desc = 'resize' },
    },
    { '=', '<C-w>=', { desc = false } },

    { 's', pcmd('split', 'E36'), { desc = 'hsplit' } },
    { '<C-s>', pcmd('split', 'E36'), { desc = false } },
    { 'v', pcmd('vsplit', 'E36'), { desc = 'vsplit' } },
    { '<C-v>', pcmd('vsplit', 'E36'), { desc = false } },

    { 'q', pcmd('close', 'E444'), { desc = 'close window' } },

    { '<Esc>', nil, { exit = true, desc = false } },
  },
}
