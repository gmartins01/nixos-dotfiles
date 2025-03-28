return {
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
      }
    end,
  },
  
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },

  { "catppuccin/nvim", 
    name = "catppuccin", 
    priority = 1000
  },
}

