-------------------- lsp configuration --------------------

vim.lsp.enable({
  "azure_pipelines_ls",
  "bashls",
  "gopls",
  "helm_ls",
  "jsonls",
  "lua_ls",
  "pylsp",
  "ruff",
  "yamlls",
})

-- add lsp plugins

local loong = require("core.loong")

-- lsp installer
-- https://github.com/mason-org/mason.nvim
loong.add_plugin("mason-org/mason.nvim", {
  opts = {},
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
  end,
})

-- fotmat
-- https://github.com/stevearc/conform.nvim
loong.add_plugin("stevearc/conform.nvim", {
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("which-key").add({
      {
        "<leader>fp",
        function()
          require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
        end,
        desc = "Format File",
        mode = "n",
      },
    })
    require("conform").setup({
      default_format_opts = {
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofmt" },
        sh = { "shfmt" },
        python = { "isort", "black" },
        ["*"] = { "codespell" },
        ["_"] = { "trim_whitespace" },
      },
      -- format_on_save = {
      --   lsp_fallback = true,
      --   async = false,
      --   timeout_ms = 500,
      -- },
      formatters = {
        injected = { options = { ignore_errors = true } },
      },
      keys = {},
    })
  end,
})
