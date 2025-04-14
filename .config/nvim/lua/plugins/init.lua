return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
	},

	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{ "ThePrimeagen/harpoon" },

	{ "mbbill/undotree" },

		"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
}
