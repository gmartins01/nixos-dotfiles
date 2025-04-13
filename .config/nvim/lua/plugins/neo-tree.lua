return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = true,
	---@module "neo-tree"
	---@type neotree.Config?
	opts = {},

	keys = function()
		local find_buffer_by_type = function(type)
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				local ft = vim.bo[buf].filetype
				if ft == type then
					return buf
				end
			end
			return -1
		end
		local toggle_neotree = function(toggle_command)
			if find_buffer_by_type("neo-tree") > 0 then
				require("neo-tree.command").execute({ action = "close" })
			else
				toggle_command()
			end
		end

		return {
			{
				"<leader>e",
				function()
					toggle_neotree(function()
						require("neo-tree.command").execute({ action = "focus", reveal = true, dir = vim.uv.cwd() })
					end)
				end,
				desc = "Toggle Explorer (cwd)",
			},
			{
				"<leader>E",
				function()
					toggle_neotree(function()
						require("neo-tree.command").execute({ action = "focus", reveal = true })
					end)
				end,
				desc = "Toggle Explorer (root)",
			},
		}
	end,
}
