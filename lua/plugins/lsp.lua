-- Dedicated to configuring Language Server Protocol (LSP) related plugins.
-- Includes LSP clients, language server installers, and tools that integrate with LSP features.

local loong = require('core.loong')

loong.add_plugin('mason-org/mason.nvim', { opts = {} })

-- handle the inconsistent naming issue between mason.nvim and nvim-lspconfig.
-- https://github.com/mason-org/mason-lspconfig.nvim
loong.add_plugin('mason-org/mason-lspconfig.nvim', {
  dependencies = {
    'mason-org/mason.nvim',
    'neovim/nvim-lspconfig',
  },
  opts = {
    ensure_installed = {
      'ruff', -- "black", "isort",
      'lua_ls', -- "stylua",
      'gopls', -- "goimports", "gofmt",
      'yamlls',
      'helm_ls',
      'azure_pipelines_ls',
      -- "rustfmt",
      -- "shfmt",
      -- "codespell",
      -- "trim_whitespace",
    },
  },
})

-- Quickstart configs for Nvim LSP
-- https://github.com/neovim/nvim-lspconfig
loong.add_plugin('neovim/nvim-lspconfig', {
  config = function()
    local lspconfig = require('lspconfig')
    lspconfig.ruff.setup({})
    lspconfig.lua_ls.setup({})
    lspconfig.gopls.setup({})
    lspconfig.yamlls.setup({
      settings = {
        yaml = {
          schemas = {
            ['https://raw.githubusercontent.com/yannh/kubernetes-yaml-schema/master/helm.json'] = '/*.helm.yaml',
            ['https://raw.githubusercontent.com/Azure/azure-pipelines-vscode/master/resources/pipeline.schema.json'] = 'azure-pipelines.yml',
          },
        },
      },
    })
    -- Helm Language Server Configuration
    lspconfig.helm_ls.setup({})
    -- Azure Pipelines Language Server Configuration
    lspconfig.azure_pipelines_ls.setup({})
  end,
})
