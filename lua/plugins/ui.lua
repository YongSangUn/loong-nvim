-- Contains configurations for Neovim plugins that enhance the User Interface (UI).
-- This includes statuslines, file explorers, icons, and colorschemes.

local loong = require('core.loong')

loong.add_plugin(
  -- scrollo
  -- https://github.com/karb94/neoscroll.nvim
  'karb94/neoscroll.nvim',
  {
    config = function()
      require('neoscroll').setup({})
    end,
  }
)

-- Indent Blankline
-- https://github.com/lukas-reineke/indent-blankline.nvim
loong.add_plugin('lukas-reineke/indent-blankline.nvim', {
  main = 'ibl',
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
  config = function()
    require('ibl').setup()
  end,
})

-- dashboard
-- https://github.com/nvimdev/dashboard-nvim
loong.add_plugin('nvimdev/dashboard-nvim', {
  event = 'VimEnter',
  config = function()
    require('dashboard').setup({
      -- config
    })
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
})
