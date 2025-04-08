return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 10,
				open_mapping = [[<C-\>]],
				hide_numbers = true,
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 4,
				start_in_insert = true,
				insert_mappings = true,
				persist_size = true,
				direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float'
				close_on_exit = true,
				shell = vim.o.shell,
			})
		end,
	},
}
