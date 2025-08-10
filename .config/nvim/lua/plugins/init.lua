return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
	},

	-- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	{
		"vague2k/vague.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other plugins
	},

	-- { "rebelot/kanagawa.nvim", priority = 1000 },

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
}
