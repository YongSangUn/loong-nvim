local LspConfig = {}

LspConfig = {
  ['bash-language-server'] = { formatter = 'shfmt' },
  ['python-lsp-server'] = {
    setup = {
      settings = {
        pylsp = {
          plugins = {
            pycodestyle = { enabled = false },
            pyflakes = { enabled = false },
          },
        },
      },
    },
  },
  ruff = {
    formatter = 'black',
    setup = {
      init_options = {
        settings = { lineLength = 120 },
      },
    },
  },
  ['lua-language-server'] = {
    formatter = 'stylua',
    setup = {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            path = (function()
              local runtime_path = vim.split(package.path, ';')
              table.insert(runtime_path, 'lua/?.lua')
              table.insert(runtime_path, 'lua/?/init.lua')
              return runtime_path
            end)(),
          },
          diagnostics = {
            globals = { 'vim' },
          },
          -- hint = {
          --   enable = true,
          -- },
          workspace = {
            library = {
              vim.env.VIMRUNTIME,
              '${3rd}/luv/library',
            },
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },
  },
  gopls = { formatter = 'gofumpt' },
  ['azure-pipelines-language-server'] = {},
  ['helm-ls'] = {},
  ['yaml-language-server'] = {
    fotmatter = 'prettier',
    setup = {
      settings = {
        yaml = {
          schemas = {
            ['https://raw.githubusercontent.com/yannh/kubernetes-yaml-schema/master/helm.json'] = '/*.helm.yaml',
            ['https://raw.githubusercontent.com/Azure/azure-pipelines-vscode/master/resources/pipeline.schema.json'] = 'azure-pipelines.yml',
          },
        },
      },
    },
  },
  ['json-lsp'] = { formatter = 'prettier' },
}

return LspConfig
