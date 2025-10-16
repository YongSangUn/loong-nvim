--- @brief
---
--- https://github.com/hrsh7th/vscode-langservers-extracted
---
--- `vscode-eslint-language-server` is a linting engine for JavaScript / Typescript.
--- It can be installed via `npm`:
---
--- ```sh
--- npm i -g vscode-langservers-extracted
--- ```
---
--- The default `on_attach` config provides the `LspEslintFixAll` command that can be used to format a document on save:
--- ```lua
--- local base_on_attach = vim.lsp.config.eslint.on_attach
--- vim.lsp.config("eslint", {
---   on_attach = function(client, bufnr)
---     if not base_on_attach then return end
---
---     base_on_attach(client, bufnr)
---     vim.api.nvim_create_autocmd("BufWritePre", {
---       buffer = bufnr,
---       command = "LspEslintFixAll",
---     })
---   end,
--- })
--- ```
---
--- See [vscode-eslint](https://github.com/microsoft/vscode-eslint/blob/55871979d7af184bf09af491b6ea35ebd56822cf/server/src/eslintServer.ts#L216-L229) for configuration options.
---
--- Messages handled in lspconfig: `eslint/openDoc`, `eslint/confirmESLintExecution`, `eslint/probeFailed`, `eslint/noLibrary`
---
--- Additional messages you can handle: `eslint/noConfig`
---
--- ### Monorepo support
---
--- `vscode-eslint-language-server` supports monorepos by default. It will automatically find the config file corresponding to the package you are working on. You can use different configs in different packages.
--- This works without the need of spawning multiple instances of `vscode-eslint-language-server`.
--- You can use a different version of ESLint in each package, but it is recommended to use the same version of ESLint in all packages. The location of the ESLint binary will be determined automatically.
---
--- /!\ When using flat config files, you need to use them across all your packages in your monorepo, as it's a global setting for the server.

return {
  -- custom start --
  lsp_server = "eslint-lsp",
  formatter = {},
  -- custom end --
  default_config = {
    cmd = { "vscode-eslint-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "vue",
      "svelte",
      "astro",
    },
    root_markers = {
      ".eslintrc",
      ".eslintrc.js",
      ".eslintrc.cjs",
      ".eslintrc.yaml",
      ".eslintrc.yml",
      ".eslintrc.json",
      "eslint.config.js",
      "eslint.config.mjs",
      "eslint.config.cjs",
      "eslint.config.ts",
      "eslint.config.mts",
      "eslint.config.cts",
      "package.json",
    },
    settings = {
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = "separateLine",
        },
        showDocumentation = {
          enable = true,
        },
      },
      codeActionOnSave = {
        enable = false,
        mode = "all",
      },
      experimental = {
        useFlatConfig = false,
      },
      format = true,
      nodePath = "",
      onIgnoredFiles = "off",
      problems = {
        shortenToSingleLine = false,
      },
      quiet = false,
      rulesCustomizations = {},
      run = "onType",
      useESLintClass = false,
      validate = "on",
      workingDirectory = {
        mode = "location",
      },
    },
  },
}
