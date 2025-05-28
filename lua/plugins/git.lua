-- Manages configurations for Neovim plugins that integrate with Git.
-- Covers Git status indicators, diffs, blame, and other version control operations.

local loong = require('core.loong')

-- git
-- https://github.com/NeogitOrg/neogit
loong.add_plugin('NeogitOrg/neogit', {
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration

    -- Only one of these is needed.
    'nvim-telescope/telescope.nvim', -- optional
    -- "ibhagwan/fzf-lua",              -- optional
    -- "echasnovski/mini.pick",         -- optional
    -- "folke/snacks.nvim",             -- optional
  },

  config = function()
    require('which-key').add({
      { '<leader>gs', ':lua require("neogit").open()<cr>', desc = 'Neogit status', mode = 'n' },
    })
  end,
})
