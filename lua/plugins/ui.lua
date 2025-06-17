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

-- bufferline
-- https://github.com/akinsho/bufferline.nvim
loong.add_plugin('akinsho/bufferline.nvim', {
  enent = 'BufRead',
  config = function()
    require('bufferline').setup({
      -- pass
    })
    require('which-key').add({
      {
        '<leader>bb',
        "<cmd>lua require('telescope.builtin').buffers { sort_mru = true }<cr>",
        desc = 'List buffers',
        mode = 'n',
      },
      { '<leader>bn', ':BufferLineCycleNext<CR>', desc = 'Next buffer', mode = 'n' },
      { '<leader>bp', ':BufferLineCyclePrev<CR>', desc = 'Previous buffer', mode = 'n' },
      { '<leader>bd', ':bw<CR>', desc = 'Delete buffer', mode = 'n' },
    })
  end,
})


-- cli
-- https://github.com/folke/noice.nvim
loong.add_plugin('folke/noice.nvim', {
  event = 'VeryLazy',
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    'rcarriga/nvim-notify',
  },
})

-- nvim-web-devicons
-- https://github.com/nvim-tree/nvim-web-devicons
loong.add_plugin('nvim-tree/nvim-web-devicons', {
  config = function()
    require('nvim-web-devicons').setup({
      -- your personnal icons can go here (to override)
    })
  end,
})
