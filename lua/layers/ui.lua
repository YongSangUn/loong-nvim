-- Contains configurations for Neovim plugins that enhance the User Interface (UI).
-- This includes statuslines, file explorers, icons, and colorschemes.

local loong = require("core.loong")

-- scrollo
-- https://github.com/karb94/neoscroll.nvim
loong.add_plugin("karb94/neoscroll.nvim", {
  opts = {},
})

-- bufferline
-- https://github.com/akinsho/bufferline.nvim
loong.add_plugin("akinsho/bufferline.nvim", {
  dependencies = { "nvim-tree/nvim-web-devicons" },
  branch = "main",
  lazy = false,
  keys = {
    { "<leader>bn", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer", mode = "n" },
    { "<leader>bp", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer", mode = "n" },
    { "<leader>bs", "<cmd>BufferLinePick<CR>", desc = "Select buffer", mode = "n" },
    { "<leader>bd", "<cmd>bw<CR>", desc = "Delete buffer", mode = "n" },
  },
  opts = {
    options = {
      offsets = {
        { filetype = "NvimTree", text = " File Explorer", highlight = "Directory", separator = true },
      },
      -- indicator = { style = "icon", icon = " " },
      indicator = { style = "underline" },
    },
    highlights = {
      buffer_selected = { underline = true, sp = { attribute = "fg", highlight = "Directory" } },
      indicator_selected = { underline = true, sp = { attribute = "fg", highlight = "Directory" } },
      close_button_selected = { underline = true, sp = { attribute = "fg", highlight = "Directory" } },
    },
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
  opts = {
    options = { theme = "horizon" },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
})
