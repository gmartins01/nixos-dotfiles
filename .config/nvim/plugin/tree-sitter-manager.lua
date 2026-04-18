vim.pack.add({
  "https://github.com/romus204/tree-sitter-manager.nvim",
}, { confirm = false })

require("tree-sitter-manager").setup({})
