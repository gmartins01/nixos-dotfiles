return {
	-- Add indentation guides even on blank lines
	"brenoprata10/nvim-highlight-colors",

	config = function()
		require("nvim-highlight-colors").setup({})
	end,
}
