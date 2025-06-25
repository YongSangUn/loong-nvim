-- Dedicated to configuring Language Server Protocol (LSP) related plugins.
-- Includes LSP clients, language server installers, and tools that integrate with LSP features.

local loong = require('core.loong')

-- ref: https://github.com/Shaobin-Jiang/IceNvim/blob/a11738f57ec371960ed7d13d7ec85a90834a81ca/lua/lsp/plugins.lua#L50
loong.add_plugin('mason-org/mason.nvim', {
  dependencies = {
    'neovim/nvim-lspconfig',
    'mason-org/mason-lspconfig.nvim',
  },
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local notify = require('notify')
    -- notify('Mason config function started.')
    local LspConfig = require('plugins.lsp_config')
    -- notify('LspConfig content: ' .. vim.inspect(LspConfig))

    require('mason').setup()

    local registry = require('mason-registry')
    local function install(package)
      local s, p = pcall(registry.get_package, package)
      if s and not p:is_installed() then
        notify('Mason installing ' .. package)
        p:install()
      else
        notify('Mason ' .. package .. ' already installed')
      end
    end

    local lspconfig = require('lspconfig')
    local mason_lspconfig_mapping = require('mason-lspconfig').get_mappings().package_to_lspconfig

    local installed_packages = registry.get_installed_package_names()
    -- notify('Installed packages: ' .. vim.inspect(installed_packages))

    for lsp, _ in pairs(LspConfig) do
      -- notify('Installing LSP: ' .. lsp)
      if vim.tbl_contains(installed_packages, lsp) then
        goto continue
      end

      local formatter = config.formatter
      install(lsp)
      if formatter ~= nil then
        install(formatter)
      end

      ::continue::
    end

    for lsp, config in pairs(LspConfig) do
      lsp = mason_lspconfig_mapping[lsp]
      if not config.managed_by_plugin and lspconfig[lsp] ~= nil then
        -- notify('Setup LSP: ' .. lsp)
        local setup = config.setup
        if type(setup) == 'function' then
          setup = setup()
        elseif setup == nil then
          setup = {}
        end

        local blink_capabilities = require('blink.cmp').get_lsp_capabilities()
        blink_capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        }
        setup = vim.tbl_deep_extend('force', setup, {
          capabilities = blink_capabilities,
        })

        -- notify('Setup done ' .. lsp .. ': ' .. vim.inspect(setup))
        vim.lsp.config(lsp, setup)
        vim.lsp.enable(lsp)
      end
    end

    vim.diagnostic.config({
      update_in_insert = true,
      severity_sort = true,
      virtual_text = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.HINT] = '',
          [vim.diagnostic.severity.INFO] = '',
        },
      },
    })

    vim.lsp.inlay_hint.enable()
  end,
})
