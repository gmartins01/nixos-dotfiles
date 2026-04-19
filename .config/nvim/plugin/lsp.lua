local lsp_servers = {
  lua_ls = {
    settings = {
      Lua = {
        workspace = {
          library = vim.api.nvim_get_runtime_file("lua", true),
        },
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  },

  qmlls = {},

  angularls = {
    filetypes = { "typescript", "html", "typescriptreact", "htmlangular" },
    root_markers = { "angular.json", "nx.json" },
  },
}

local ensure_installed = vim.tbl_keys(lsp_servers)
vim.list_extend(ensure_installed, {
  "stylua",
  "alejandra",
})

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/folke/lazydev.nvim",

  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",

  "https://github.com/saghen/blink.cmp",
  "https://github.com/rafamadriz/friendly-snippets",
}, { confirm = false })

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = ensure_installed,
})

-- Completion
local blink = require("blink.cmp")

blink.setup({
  signature = { enabled = true },

  completion = {
    documentation = {
      auto_show = true,
    },
  },

  keymap = {
    ["<C-n>"] = { "select_next", "fallback_to_mappings" },
    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-y>"] = { "select_and_accept", "fallback" },
    ["<C-e>"] = { "cancel", "fallback" },

    ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },

    ["<CR>"] = { "select_and_accept", "fallback" },

    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
  },

  sources = {
    default = { "lazydev", "lsp", "snippets", "buffer", "path" },

    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },

  fuzzy = {
    implementation = "lua",
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),

  callback = function(args)
    local bufnr = args.buf

    -- local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- if not client then
    --   return
    -- end

    -- if client:supports_method("textDocument/documentHighlight") then
    --   local highlight_group = vim.api.nvim_create_augroup("user-lsp-highlight", { clear = false })
    --
    --   vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    --     buffer = args.buf,
    --     group = highlight_group,
    --     callback = function()
    --       vim.b[args.buf].lsp_highlight_word = vim.fn.expand("<cword>")
    --       vim.lsp.buf.document_highlight()
    --     end,
    --   })
    --
    --   vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    --     buffer = args.buf,
    --     group = highlight_group,
    --     callback = function()
    --       if vim.b[args.buf].lsp_highlight_word ~= vim.fn.expand("<cword>") then
    --         vim.lsp.buf.clear_references()
    --         vim.b[args.buf].lsp_highlight_word = nil
    --       end
    --     end,
    --   })
    --
    --   vim.api.nvim_create_autocmd("LspDetach", {
    --     group = vim.api.nvim_create_augroup("user-lsp-detach", { clear = true }),
    --
    --     callback = function(detach_event)
    --       vim.lsp.buf.clear_references()
    --
    --       vim.api.nvim_clear_autocmds({
    --         group = "user-lsp-highlight",
    --         buffer = detach_event.buf,
    --       })
    --     end,
    --   })
    -- end

    local map = function(keys, func, desc, mode)
      vim.keymap.set(mode or "n", keys, func, {
        buffer = bufnr,
        desc = "LSP: " .. desc,
      })
    end

    map("gd", function()
      require("telescope.builtin").lsp_definitions()
    end, "[G]oto [D]efinition")

    map("gr", function()
      require("telescope.builtin").lsp_references()
    end, "[G]oto [R]eferences")

    map("gi", function()
      require("telescope.builtin").lsp_implementations()
    end, "[G]oto [I]mplementation")

    map("gy", function()
      require("telescope.builtin").lsp_type_definitions()
    end, "[G]oto T[y]pe Definition")

    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    map("K", vim.lsp.buf.hover, "Hover")

    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "v" })

    -- map("<leader>f", function()
    --   vim.lsp.buf.format({ async = true })
    -- end, "[F]ormat")

    map("<leader>cc", vim.lsp.codelens.run, "[C]odeLens")

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }))
      end, "[T]oggle Inlay [H]ints")
    end
  end,
})

local capabilities = blink.get_lsp_capabilities()

for server, config in pairs(lsp_servers) do
  config.capabilities = capabilities
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end

-- Lazydev
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    local ok, lazydev = pcall(require, "lazydev")
    if ok then
      lazydev.setup({
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      })
    end
  end,
})

-- vim.lsp.codelens.enable(true)
