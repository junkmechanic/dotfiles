require('copilot').setup {
  suggestion = { enabled = false },
  panel = { enabled = false },
  copilot_node_command = vim.fn.expand '$HOME' .. '/.nvm/versions/node/v19.8.1/bin/node',
}
