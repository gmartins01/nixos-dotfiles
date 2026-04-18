vim.pack.add({
  "https://github.com/folke/trouble.nvim",
})

local trouble = require("trouble")
trouble.setup({})

vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "if_many",
    focusable = true,
    header = "",
    prefix = "",
    max_width = 90,
    max_height = 20,
    wrap = true,
    scope = "cursor",
  },
})

local diag_float_grp = vim.api.nvim_create_augroup("UserDiagnosticsFloat", { clear = true })

vim.api.nvim_create_autocmd("CursorHold", {
  group = diag_float_grp,
  callback = function()
    vim.diagnostic.open_float(nil, {
      focus = false,
      scope = "cursor",
      close_events = {
        "CursorMoved",
        "InsertEnter",
        "FocusLost",
      },
    })
  end,
})

vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float(nil, {
    scope = "line",
    focus = false,
    border = "rounded",
    source = "if_many",
  })
end, { desc = "Diagnostics (line)" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous Diagnostic" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Next Diagnostic" })

vim.keymap.set("n", "<leader>q", function()
  vim.diagnostic.setloclist()
end, { desc = "Diagnostics to Location List" })

vim.keymap.set("n", "<leader>xx", function()
  require("trouble").toggle("diagnostics")
end, { desc = "Diagnostics Panel" })

vim.keymap.set("n", "<leader>xq", function()
  require("trouble").toggle("quickfix")
end, { desc = "Quickfix Panel" })
