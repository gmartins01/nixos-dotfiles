return {
  "windwp/nvim-ts-autotag",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = { "html", "xml", "javascriptreact", "typescriptreact", "javascript", "typescript" },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}
