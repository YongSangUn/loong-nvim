-- Manages configurations for plugins that improve the core text editing experience.
-- Covers text manipulation, movement, commenting, and structural editing.
local loong = require("core.loong")

loong.add_plugin(
  -- file explor
  -- https://github.com/nvim-tree/nvim-tree.lua
  "nvim-tree/nvim-tree.lua",
  {
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        ---### ahmedkhalf/project.nvim dependencies ---
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
      })
      require("which-key").add({
        { "<leader>ft", "<cmd>NvimTreeToggle<cr>", desc = "Open NvimTree", mode = "n" },
      })
    end,
  }
)

-- search
-- https://github.com/nvim-telescope/telescope.nvim
loong.add_plugin("nvim-telescope/telescope.nvim", {
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
    {
      "nvim-telescope/telescope-project.nvim",
      dependencies = {
        "nvim-telescope/telescope.nvim",
      },
    },
  },
  config = function()
    require("which-key").add({
      { "<leader>pp", "<cmd>Telescope projects<cr>", desc = "List Projects", mode = "n" },
      { "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "List Project files", mode = "n" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Search text in current project", mode = "n" },
    })
    require("telescope").setup({})
    require("telescope").load_extension("project")
  end,
})

-- project
-- https://github.com/ahmedkhalf/project.nvim
loong.add_plugin("ahmedkhalf/project.nvim", {
  config = function()
    require("project_nvim").setup({
      exclude_dirs = { "*//*" },
      detection_methods = { "pattern" },
      patterns = { ".git" },
    })
  end,
})

loong.add_plugin("towolf/vim-helm", {
  ft = "helm",
  config = function()
    vim.filetype.add({
      pattern = {
        -- Chart.yaml
        ["Chart.yaml"] = "helm",
        ["values.yaml"] = "helm",
        [".*templates/.*%.yaml"] = "helm",
        [".*templates/.*%.yml"] = "helm",
      },
    })
  end,
})

--- Treesitter
--- https://github.com/nvim-treesitter/nvim-treesitter
--- ref: https://github.com/Shaobin-Jiang/IceNvim/blob/a11738f57ec371960ed7d13d7ec85a90834a81ca/lua/plugins/config.lua#L567
loong.add_plugin("nvim-treesitter/nvim-treesitter", {
  build = ":TSUpdate",
  branch = "main",
  config = function()
    local ensure_installed = {
      "bash",
      "c",
      "c_sharp",
      "cpp",
      "css",
      "go",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "rust",
      "toml",
      "vim",
      "vimdoc",
    }
    local nvim_treesitter = require("nvim-treesitter")
    nvim_treesitter.setup()

    local pattern = {}
    for _, parser in ipairs(ensure_installed) do
      local has_parser, _ = pcall(vim.treesitter.language.inspect, parser)

      if not has_parser then
        -- Needs restart to take effect
        nvim_treesitter.install(parser)
      else
        vim.list_extend(pattern, vim.treesitter.language.get_filetypes(parser))
      end
    end
    local group = vim.api.nvim_create_augroup("NvimTreesitterFt", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = pattern,
      callback = function(ev)
        local max_filesize = 100 * 1024
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
        if not (ok and stats and stats.size > max_filesize) then
          vim.treesitter.start()
        end
      end,
    })

    vim.api.nvim_exec_autocmds("FileType", { group = "NvimTreesitterFt" })
  end,
})

-- terminal
-- toggleterm.setup()
-- https://github.com/akinsho/toggleterm.nvim
loong.add_plugin("akinsho/toggleterm.nvim", {
  branch = "main",
  event = "BufRead",
  config = function()
    require("toggleterm").setup({
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    })

    require("which-key").add({
      { "<leader>'", '<cmd>exe v:count1 . "ToggleTerm"<CR>', desc = "Open shell", mode = "n" },
    })
  end,
})

-- code navigation
-- https://github.com/folke/flash.nvim
loong.add_plugin("folke/flash.nvim", {
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },
    {
      "<c-s>",
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search",
    },
  },
})

-- markdown
-- https://github.com/MeanderingProgrammer/render-markdown.nvim
loong.add_plugin("MeanderingProgrammer/render-markdown.nvim", {
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  ft = { "markdown", "Avante", "vimwiki" },
  config = function()
    require("render-markdown").setup({
      completions = { blink = { enabled = true } },
      file_types = { "markdown", "vimwiki", "Avante" },
    })
  end,
})

-- autopairs
-- https://github.com/windwp/nvim-autopairs
loong.add_plugin("windwp/nvim-autopairs", {
  branch = "master",
  config = function()
    local autopairs = require("nvim-autopairs")
    autopairs.setup({
      disable_filetype = { "TelescopePrompt", "vim" },
    })
  end,
})
