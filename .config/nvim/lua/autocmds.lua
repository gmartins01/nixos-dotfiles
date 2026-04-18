-- Highlight when copy
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Create an autocmd group for toggling relative number
vim.api.nvim_create_augroup("RelativeNumberToggle", { clear = true })

-- Disable relative numbering when entering Insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  group = "RelativeNumberToggle",
  pattern = "*",
  callback = function()
    vim.opt.relativenumber = false
  end,
})

-- Re-enable relative numbering when leaving Insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  group = "RelativeNumberToggle",
  pattern = "*",
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- Terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})
