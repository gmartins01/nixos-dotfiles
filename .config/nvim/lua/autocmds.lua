-- Highlight when copy
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#a6d189", fg = "#2e3440" })
  end,
})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Highlight selection on yank",
  callback = function()
    vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 200 })
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
