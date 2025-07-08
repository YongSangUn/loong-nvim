local loong = require("core.loong")

vim.lsp.enable(loong.lsp_enabled)

vim.diagnostic.config({
  update_in_insert = true,
  severity_sort = true, -- necessary for lspsaga's show_line_diagnostics to work
  virtual_text = true,
})

-- lsp installer
-- https://github.com/mason-org/mason.nvim
loong.add_plugin("mason-org/mason.nvim", {
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)
    local mr = require("mason-registry")
    -- ref https://github.com/adibhanna/nvim/blob/main/lua/plugins/mason.lua
    local function install_pkg()
      vim.notify("Mason: Installing packages...", vim.inspect(loong.ensure_installed))
      for _, pkg in ipairs(loong.ensure_installed) do
        if mr.has_package(pkg) then
          local p = mr.get_package(pkg)
          if not p:is_installed() then
            -- vim.notify("Mason: Installing " .. pkg .. "...", vim.log.levels.INFO)
            p:install():once("closed", function()
              if p:is_installed() then
                vim.notify("Mason: Successfully installed " .. pkg, vim.log.levels.INFO)
              else
                vim.notify("Mason: Failed to install " .. pkg, vim.log.levels.ERROR)
              end
            end)
          end
        end
      end
    end
    if mr.refresh then
      mr.refresh(install_pkg)
    else
      install_pkg()
    end
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
        -- sql = { "sqlfluff" },
        -- ["*"] = { "codespell" },
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
