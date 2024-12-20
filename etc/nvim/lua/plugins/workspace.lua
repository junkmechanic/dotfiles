return {
  {
    "olimorris/persisted.nvim",
    lazy = false,
    priority = 100,
    config = function()
      require 'config.persisted'
    end,
  },
}
