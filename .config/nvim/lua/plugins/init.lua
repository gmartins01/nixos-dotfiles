return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
	},

	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	{ "rose-pine/neovim", name = "rose-pine" },

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{ "ThePrimeagen/harpoon" },

	{ "mbbill/undotree" },

	-- Git Integration
	{ "tpope/vim-fugitive" },

	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
}
