return	{
	"stevearc/oil.nvim",

	config = function ()
		require("oil").setup({
			default_file_explorer = true,

			view_options = {
				show_hidden = true,
			},
		})

		-- Open parent directory in current window
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", {desc = "Open parent directory"})

		-- Open parent directory in floating window
		vim.keymap.set("n", "<leader>-", require("oil").toggle_float, {desc = "Open parent directory in floating window"})

	end,
}
