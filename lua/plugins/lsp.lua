local loong = require('core.loong')

vim.lsp.enable('lua_ls')
vim.lsp.enable('ruff')

-- ref: https://github.com/patricorgi/dotfiles/blob/main/.config/nvim/lua/custom/lsp.lua
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    -- vim.keymap.set('n', 'gd', function()
    --   local params = vim.lsp.util.make_position_params(0, 'utf-8')
    --   vim.lsp.buf_request(0, 'textDocument/definition', params, function(_, result, _, _)
    --     if not result or vim.tbl_isempty(result) then
    --       vim.notify('No definition found', vim.log.levels.INFO)
    --     else
    --       require('snacks').picker.lsp_definitions()
    --     end
    --   end)
    -- end, { buffer = event.buf, desc = 'LSP: Goto Definition' })
  end,
})

-----------------------------
-- mason.nvim
-- https://github.com/williamboman/mason.nvim
loong.add_plugin('mason-org/mason.nvim', {
  event = { 'BufReadPost', 'BufNewFile', 'VimEnter' },
  opts = {},
  dependencies = {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    local mason = require('mason')

    local mason_tool_installer = require('mason-tool-installer')

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        'ruff',
        'black',
        'isort',
        'lua-language-server',
        'stylua',
        'gopls',
        'goimports',
        'yaml-language-server',
        'helm-ls',
        'azure-pipelines-language-server',
        'rustfmt',
        'shfmt',
        'codespell',
        'prettier',
      },
    })
  end,
})

-- handle the inconsistent naming issue between mason.nvim and nvim-lspconfig.
-- https://github.com/mason-org/mason-lspconfig.nvim
-- loong.add_plugin('mason-org/mason-lspconfig.nvim', {
--   dependencies = {
--     'mason-org/mason.nvim',
--     'neovim/nvim-lspconfig',
--   },
--   opts = {
--     ensure_installed = {
--       'ruff', -- "black", "isort",
--       'lua_ls', -- "stylua",
--       'gopls', -- "goimports", "gofmt",
--       'yamlls',
--       'helm_ls',
--       'azure_pipelines_ls',
--       -- "rustfmt",
--       -- "shfmt",
--       -- "codespell",
--       -- "trim_whitespace",
--     },
--   },
-- })

-- Quickstart configs for Nvim LSP
-- https://github.com/neovim/nvim-lspconfig
-- loong.add_plugin('neovim/nvim-lspconfig', {
--   opts = {
--     servers = {
--       ruff = {},
--       lua_ls = {},
--       gopls = {},
--       yamlls = {
--         settings = {
--           yaml = {
--             schemas = {
--               ['https://raw.githubusercontent.com/yannh/kubernetes-yaml-schema/master/helm.json'] = '/*.helm.yaml',
--               ['https://raw.githubusercontent.com/Azure/azure-pipelines-vscode/master/resources/pipeline.schema.json'] = 'azure-pipelines.yml',
--             },
--           },
--         },
--       },
--       helm_ls = {},
--       azure_pipelines_ls = {},
--     },
--   },
--   config = function(_, opts)
--     local lspconfig = require('lspconfig')
--     for server, config in pairs(opts.servers) do
--       -- passing config.capabilities to blink.cmp merges with the capabilities in your
--       -- `opts[server].capabilities, if you've defined it
--       config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
--       lspconfig[server].setup(config)
--     end
--   end,
-- })
