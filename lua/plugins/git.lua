-- Manages configurations for Neovim plugins that integrate with Git.
-- Covers Git status indicators, diffs, blame, and other version control operations.

local loong = require("core.loong")

-- git
-- https://github.com/NeogitOrg/neogit
loong.add_plugin("NeogitOrg/neogit", {
  dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
  keys = {
    { "<leader>gs", ":Neogit<cr>", mode = "n", desc = "Toggle blame window" },
  },
})

-- blame
-- https://github.com/lewis6991/gitsigns.nvim
loong.add_plugin("lewis6991/gitsigns.nvim", {
  event = { "BufRead", "BufNewFile" },
  lazy = true,
  opts = {
    current_line_blame = true,
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    current_line_blame_opts = { delay = 100 },
  },
})

-- https://github.com/FabijanZulj/blame.nvim
loong.add_plugin("FabijanZulj/blame.nvim", {
  lazy = false,
  opts = {}, -- must use opts to setup() or config instead.
  keys = {
    { "<leader>gb", ":BlameToggle window<cr>", mode = "n", desc = "Toggle blame window" },
  },
})
