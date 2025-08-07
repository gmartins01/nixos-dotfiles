return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",

	config = function()
		require("nvim-autopairs").setup({
			check_ts = true,
			disable_filetype = { "TelescopePrompt" },
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				offset = 0,
				end_key = "$",
				check_comma = true,
			},
		})
	end,
}
