-- Contains configurations for Neovim plugins that enhance the User Interface (UI).
-- This includes statuslines, file explorers, icons, and colorschemes.

local loong = require("core.loong")

-- scrollo
-- https://github.com/karb94/neoscroll.nvim
loong.add_plugin("karb94/neoscroll.nvim", {
  opts = {},
})

-- Indent Blankline
-- https://github.com/lukas-reineke/indent-blankline.nvim
loong.add_plugin("lukas-reineke/indent-blankline.nvim", {
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
})

-- dashboard
-- https://github.com/nvimdev/dashboard-nvim
loong.add_plugin("nvimdev/dashboard-nvim", {
  event = "VimEnter",
  opts = {
    theme = "doom",
    config = {
      -- footer = { utils.get_quote() },
      center = {
        {
          icon = "  ",
          desc = "List Projects",
          action = "Telescope projects",
          shortcut = "SPC p p",
        },
        {
          icon = "  ",
          desc = "Recent Files",
          action = "Telescope oldfiles",
          shortcut = "SPC f f",
        },
        {
          icon = "  ",
          desc = "Find File",
          action = "Telescope find_files",
          shortcut = "SPC p f",
        },
        {
          icon = "󰊄  ",
          desc = "Find Text",
          action = "Telescope live_grep",
          shortcut = "SPC /  ",
        },
      },
    },
    preview = {
      command = "chafa --passthrough tmux -f symbols -s 80x80 -c full --fg-only --symbols braille --clear",
      file_path = vim.fn.stdpath("config") .. "/static/dashboard.gif",
      file_height = 24,
      file_width = 80,
    },
  },
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
})

-- bufferline
-- https://github.com/akinsho/bufferline.nvim
loong.add_plugin("akinsho/bufferline.nvim", {
  dependencies = { "nvim-tree/nvim-web-devicons" },
  branch = "main",
  -- event = "BufRead",
  lazy = false,
  opts = {},
  keys = {
    {
      "<leader>bb",
      "<cmd>lua require('telescope.builtin').buffers { sort_mru = true }<cr>",
      desc = "List buffers",
      mode = "n",
    },
    { "<leader>bn", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer", mode = "n" },
    { "<leader>bp", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer", mode = "n" },
    { "<leader>bd", "<cmd>bw<CR>", desc = "Delete buffer", mode = "n" },
  },
})

-- cli
-- https://github.com/folke/noice.nvim
loong.add_plugin("folke/noice.nvim", {
  event = "VeryLazy",
  opts = {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
})

-- nvim-web-devicons
-- https://github.com/nvim-tree/nvim-web-devicons
loong.add_plugin("nvim-tree/nvim-web-devicons", {
  opts = {},
})

-- lualine
-- https://github.com/nvim-lualine/lualine.nvim
loong.add_plugin("nvim-lualine/lualine.nvim", {
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
})
