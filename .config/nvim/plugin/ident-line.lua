vim.pack.add({
  "https://github.com/lukas-reineke/indent-blankline.nvim",
}, { confirm = false })

local highlight = {
  "IndentScope",
}

local hooks = require("ibl.hooks")

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "IndentScope", { fg = "#7f849c" })
end)
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)

vim.g.rainbow_delimiters = { highlight = highlight }

require("ibl").setup({
  -- indent = { char = "▏" },
  scope = {
    highlight = highlight,
    show_start = false,
    show_end = false,
    include = { node_type = { ["*"] = { "*" } } },
  },
})
