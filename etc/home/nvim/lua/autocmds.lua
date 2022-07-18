local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
  end
})

--- Remove all trailing whitespace on save
augroup("TrimWhiteSpaceGrp", { clear = true })
autocmd("BufWritePre", {
  group = 'TrimWhiteSpaceGrp',
  command = [[:%s/\s\+$//e]],
})

