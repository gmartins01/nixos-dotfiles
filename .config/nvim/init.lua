vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.pack.add({ "https://github.com/nvim-mini/mini.misc" })
require("mini.misc").setup()

_G.safely = require("mini.misc").safely

vim.diagnostic.config({
  severity_sort = true,
  virtual_lines = { current_line = true },
  underline = true,
  float = { border = vim.g.border },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
})

-- INFO: plugins
-- we install plugins with neovim's builtin package manager: vim.pack
-- and then enable/configure them by calling their setup functions.
--
-- (see `:h vim.pack` for more details on how it works)
-- you can press `gx` on any of the plugin urls below to open them in your
-- browser and check out their documentation and functionality.
-- alternatively, you can run `:h {plugin-name}` to read their documentation.
--
-- plugins are then loaded and configured with a call to `setup` functions
-- provided by each plugin. this is not a rule of neovim but rather a convention
-- followed by the community.
-- these setup calls take a table as an agument and their expected contents can
-- vary wildly. refer to each plugin's documentation for details.

-- NOTE: if all you want is lsp + completion + highlighting, you're done.
-- the rest of the lines are just quality-of-life/appearance plugins and
-- can be removed.

-- NOTE: there are many more quality-of-life plugins available and others that
-- achieve what these do. these are just our recommendations to start.

-- INFO: utility plugins
vim.pack.add({
  "https://github.com/windwp/nvim-autopairs", -- auto pairs
  "https://github.com/folke/todo-comments.nvim", -- highlight TODO/INFO/WARN comments
}, { confirm = false })

require("nvim-autopairs").setup()
require("todo-comments").setup()

-- uncomment to enable automatic plugin updates
-- vim.pack.update()

require("options")
require("autocmds")
require("ui")
require("keymaps")
