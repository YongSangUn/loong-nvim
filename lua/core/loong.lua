local M = {}

---------- plugins setup start ----------
local plugins = {}
local plugins_seen = {}

function M.add_plugin(name, opts)
  if plugins_seen[name] then
    print("Plugin " .. name .. " already added")
    return
  end
  plugins[#plugins + 1] = vim.tbl_extend("force", { name }, opts or {})
  plugins_seen[name] = true
end

local function load_plugins()
  require("plugins.theme")
  require("plugins.completion")
  require("plugins.editor")
  require("plugins.git")
  require("plugins.lsp")
  require("plugins.ui")
end
---------- plugins setup end ----------

---------- lsp config start ----------
-- default custom lsp configs
M._lsp_custom_defaults = {
  enabled = true,
  lsp_server = "",
  formatter = {},
}

M.lsp_custom_configs = {}
M.lsp_enabled = {}
M.ensure_installed = {} -- all package(lsp, formatter, linter)

-- load custom lsp configs
local function load_configs()
  local lsp_dir = vim.fn.stdpath("config") .. "/lsp"

  if vim.fn.isdirectory(lsp_dir) == 0 then
    vim.notify("LSP directory not found: " .. lsp_dir, vim.log.levels.ERROR)
    return {}
  end

  for name, ft in vim.fs.dir(lsp_dir) do
    if ft == "file" and name:match("%.lua$") and name ~= "init.lua" then
      local lsp_name = name:gsub("%.lua$", "")
      local file_path = lsp_dir .. "/" .. name
      local ok, config = pcall(dofile, file_path)

      if ok and type(config) == "table" then
        local custom = {}
        -- set default values if not set
        for key, default in pairs(M._lsp_custom_defaults) do
          if config[key] == nil then
            custom[key] = default
          else
            custom[key] = config[key]
            config[key] = nil
          end
        end

        -- 修复：添加 nil 检查和正确的字符串引用
        if custom.lsp_server ~= nil and custom.lsp_server ~= "" then
          M.ensure_installed[#M.ensure_installed + 1] = custom.lsp_server
        end

        if custom.formatter and type(custom.formatter) == "table" then
          vim.list_extend(M.ensure_installed, custom.formatter)
        else
          vim.notify("formatter: " .. tostring(custom.formatter) .. " is not a table", vim.log.levels.ERROR)
        end

        if custom.enabled ~= false then
          table.insert(M.lsp_enabled, lsp_name)
        end

        M.lsp_custom_configs[lsp_name] = custom
      else
        vim.notify("Failed to load LSP config: " .. lsp_name .. " - " .. tostring(config), vim.log.levels.ERROR)
      end
    end
  end
  M.ensure_installed = vim.fn.uniq(vim.fn.sort(M.ensure_installed))
end

---------- lsp config end ----------

local function setup()
  -- notify
  -- https://github.com/rcarriga/nvim-notify
  M.add_plugin("rcarriga/nvim-notify", {
    event = "BufRead",
    config = function()
      require("notify").setup({
        -- Animation style (see below for details)
        stages = "fade_in_slide_out",
        background_colour = "#000000",
      })
    end,
  })

  load_plugins()

  -- show keybindings in popup.
  -- https://github.com/folke/which-key.nvim
  M.add_plugin("folke/which-key.nvim", {
    event = "VeryLazy",
    opts = {},
  })

  -- Bootstrap lazy.nvim
  -- lazy.nvim docs: https://lazy.folke.io/installation
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup(plugins, {
    -- checker = {
    --   enabled = true,
    --   notify = false,
    -- },
  })
end

function M.run()
  require("core.options")
  require("core.keymaps")
  require("core.filetype")

  load_configs()
  setup()
end

return M
