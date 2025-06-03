local M = {}

local plugins = {}
local plugins_seen = {}

function M.add_plugin(name, opts)
  if plugins_seen[name] then
    print('Plugin ' .. name .. ' already added')
    return
  end
  plugins[#plugins + 1] = vim.tbl_extend('force', { name }, opts or {})
  plugins_seen[name] = true
end

local function load_plugins()
  require('plugins.completion')
  require('plugins.editor')
  require('plugins.git')
  require('plugins.lsp')
  require('plugins.ui')
end

local function setup()
  load_plugins()

  -- show keybindings in popup.
  -- https://github.com/folke/which-key.nvim
  M.add_plugin('folke/which-key.nvim', {
    event = 'VeryLazy',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function()
      local wh = require('which-key')
      wh.setup({})
      wh.add({
        -- { '<leader>', '<cmd><cr>', desc = '', mode = 'n' },
      })
    end,
    keys = {},
  })

  -- Bootstrap lazy.nvim
  -- lazy.nvim docs: https://lazy.folke.io/installation
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  require('lazy').setup(plugins, {
    -- checker = {
    --   enabled = true,
    --   notify = false,
    -- },
  })
end

function M.run()
  require('core.options')
  require('core.keymaps')

  setup()
end

return M
