vim.pack.add({
  "https://github.com/nvim-mini/mini.surround",
  "https://github.com/nvim-mini/mini.hipatterns",
  "https://github.com/nvim-mini/mini.cursorword",
  "https://github.com/nvim-mini/mini.indentscope",
}, { confirm = false })

safely("later", function()
  require("mini.surround").setup({})
end)

-- Highlight patterns in text
safely("event:BufReadPost", function()
  local hipatterns = require("mini.hipatterns")
  hipatterns.setup({
    highlighters = {
      fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
      hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
      -- todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
      -- note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)

-- Automatic highlighting of word under cursor
safely("later", function()
  require("mini.cursorword").setup()
end)

safely("later", function()
  require("mini.indentscope").setup({
    draw = {
      delay = 0,
    },

    symbol = "▏",
  })
end)
