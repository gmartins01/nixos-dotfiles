vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.pack.add({ "https://github.com/nvim-mini/mini.misc" })
require("mini.misc").setup()

_G.safely = require("mini.misc").safely

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
