-- lsp servers we want to use and their configuration
-- see `:h lspconfig-all` for available servers and their settings
local lsp_servers = {
  lua_ls = {
    -- https://luals.github.io/wiki/settings/ | `:h nvim_get_runtime_file`
    Lua = { workspace = { library = vim.api.nvim_get_runtime_file("lua", true) } },
  },

  qmlls = {},

  angularls = {
    filetypes = { "typescript", "html", "typescriptreact", "htmlangular" },
    root_markers = { "angular.json", "nx.json" },
  },
}

local ensure_installed = vim.tbl_keys(lsp_servers or {})
vim.list_extend(ensure_installed, {
  "stylua",
  "alejandra", -- format nix files
})

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig", -- default configs for lsps
  "https://github.com/folke/lazydev.nvim",

  "https://github.com/mason-org/mason.nvim", -- package manager
  "https://github.com/mason-org/mason-lspconfig.nvim", -- lspconfig bridge
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim", -- auto installer

  "https://github.com/saghen/blink.cmp", -- completion
  "https://github.com/rafamadriz/friendly-snippets", -- snippets
}, { confirm = false })

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = ensure_installed,
})

safely("event:BufReadPost,BufNewFile", function()
  local blink = require("blink.cmp")
  blink.setup({
    signature = { enabled = true },

    completion = {
      documentation = {
        auto_show = true,
      },
    },

    keymap = {
      -- these are the default blink keymaps
      ["<C-n>"] = { "select_next", "fallback_to_mappings" },
      ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-y>"] = { "select_and_accept", "fallback" },
      ["<C-e>"] = { "cancel", "fallback" },

      ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<Esc>"] = { "cancel", "hide_documentation", "fallback" },

      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    },

    fuzzy = {
      implementation = "lua",
    },

    sources = {
      default = { "lazydev", "lsp", "snippets", "buffer", "path" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        snippets = {
          opts = {
            extended_filetypes = {
              javascript = { "jsdoc" },
              dart = { "flutter" },
            },
          },
        },
      },
    },
  })

  local on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = false, buffer = bufnr }
    local map = function(keys, func, desc, mode)
      vim.keymap.set(mode or "n", keys, func, {
        buffer = bufnr,
        desc = "LSP: " .. desc,
      })
    end

    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    vim.keymap.set("n", "gr", function()
      require("telescope.builtin").lsp_references()
    end, opts)

    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {
      desc = "Code Action",
    })

    vim.keymap.set("n", "gd", function()
      require("telescope.builtin").lsp_definitions()
    end, opts)

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "grd", vim.lsp.buf.definition, opts)
    -- vim.keymap.set("n", "grf", vim.lsp.buf.format, opts)

    -- Diagnostic
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = -1 })
    end, opts)
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = 1 })
    end, opts)
  end

  -- configure each lsp server on the table
  -- to check what clients are attached to the current buffer, use
  -- `:checkhealth vim.lsp`. to view default lsp keybindings, use `:h lsp-defaults`.
  for server, config in pairs(lsp_servers) do
    config.capabilities = blink.get_lsp_capabilities(config.capabilities)
    config.on_attach = on_attach

    vim.lsp.config(server, config)
    vim.lsp.enable(server)
  end

  vim.lsp.codelens.enable(true)
end)

-- Lazydev
safely("filetype:lua", function()
  local status, lazydev = pcall(require, "lazydev")
  if status then
    lazydev.setup({
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    })
  end
end)
