return {
	-- Add indentation guides even on blank lines
	"lukas-reineke/indent-blankline.nvim",

	-- See `:help ibl`
	main = "ibl",
	event = "VeryLazy",
	opts = {},

	config = function()
		local highlight = {
			"IndentScope",
		}
		local hooks = require("ibl.hooks")

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "IndentScope", { fg = "#7f849c", bold = false })
		end)

		vim.g.rainbow_delimiters = { highlight = highlight }
		require("ibl").setup({ scope = { highlight = highlight, show_start = false } })
	end,
}
-- return {
--     "echasnovski/mini.indentscope",
--     version = false,
--     config = function()
--       local mini_indent = require("mini.indentscope")
--       mini_indent.setup {
--         draw = {
--      animation = mini_indent.gen_animation.none(),
--         },
--         symbol = "▏",
--       }
--     end,
--   }
