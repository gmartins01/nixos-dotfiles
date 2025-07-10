-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.relativenumber = true

-- Create an autocmd group for toggling relative number
vim.api.nvim_create_augroup("RelativeNumberToggle", { clear = true })

-- Disable relative numbering when entering Insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
	group = "RelativeNumberToggle",
	pattern = "*",
	callback = function()
		vim.opt.relativenumber = false
	end,
})

-- Re-enable relative numbering when leaving Insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
	group = "RelativeNumberToggle",
	pattern = "*",
	callback = function()
		vim.opt.relativenumber = true
	end,
})

-- Enable mouse mode
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--vim.schedule(function()
--	vim.opt.clipboard = "unnamedplus"
--end)

-- Tab size
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Enable break indent
vim.opt.breakindent = true

vim.opt.swapfile = false
-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--vim.opt.list = true
--vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.opt.confirm = true

require("config.keymaps")

require("config.lazy")

vim.cmd.colorscheme("catppuccin-mocha")
