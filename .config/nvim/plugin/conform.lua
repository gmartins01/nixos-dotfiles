vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
}, { confirm = false })

safely("later", function()
  require("conform").setup({
    -- event = { "BufWritePre" },
    -- cmd = { "ConformInfo" },
    notify_on_error = false,

    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      rust = { "rustfmt", lsp_format = "fallback" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      go = { "gofmt" },
      nix = { "alejandra" },
      html = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
    },
  })

  vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
  end, { desc = "[F]ormat buffer" })
end)
