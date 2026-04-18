vim.pack.add({
  "https://github.com/folke/trouble.nvim",
})

local trouble = require("trouble")
trouble.setup({})

vim.keymap.set("n", "<leader>xx", function()
  require("trouble").toggle("diagnostics")
end)

vim.keymap.set("n", "<leader>cl", function()
  require("trouble").toggle("lsp")
end)

vim.keymap.set("n", "<leader>xq", function()
  require("trouble").toggle("quickfix")
end)
