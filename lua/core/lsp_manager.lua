local M = {}

-- default custom lsp configs
M._custom_defaults = {
  enabled = true,
  formatter = {},
}

M.custom_configs = {}
M.enabled_lsps = {}

-- loac custom lsp configs
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
        for key, default in pairs(M._custom_defaults) do
          if config[key] == nil then
            custom[key] = default
          else
            custom[key] = config[key]
            config[key] = nil
          end
        end
        M.custom_configs[lsp_name] = custom

        if custom.enabled ~= false then
          table.insert(M.enabled_lsps, lsp_name)
        end
      else
        vim.notify("Failed to load LSP config: " .. lsp_name .. " - " .. tostring(config), vim.log.levels.ERROR)
      end
    end
  end
end

load_configs()

return M
