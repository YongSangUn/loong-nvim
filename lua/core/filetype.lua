vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>quit<cr>", { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  -- stylua: ignore
  pattern = {
    "html", "css", "javascript", "typescript",
    "yaml", "json", "azure-pipelines", "helm",
    "markdown",
    "lua",
    "sql",
  },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

--- add filetype azure-pipelines
vim.filetype.add({
  pattern = {
    ["azure%-?pipelines?%.ya?ml"] = "azure-pipelines",
  },
})
vim.treesitter.language.register("yaml", { "azure-pipelines" })
