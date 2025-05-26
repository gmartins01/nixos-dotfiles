return {

	"ThePrimeagen/harpoon",

	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to Harpoon" })
		vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Toggle Harpoon menu" })

		vim.keymap.set("n", "<C-1>", function()
			ui.nav_file(1)
		end, { desc = "Harpoon go to file 1" })
		vim.keymap.set("n", "<C-2>", function()
			ui.nav_file(2)
		end, { desc = "Harpoon go to file 2" })
		vim.keymap.set("n", "<C-3>", function()
			ui.nav_file(3)
		end, { desc = "Harpoon go to file 3" })
		vim.keymap.set("n", "<C-4>", function()
			ui.nav_file(4)
		end, { desc = "Harpoon go to file 4" })
	end,
}
