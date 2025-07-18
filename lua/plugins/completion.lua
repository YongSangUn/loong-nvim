-- Contains configurations for plugins that provide and manage code completion functionalities.
-- This includes the main completion engine, snippet engines, and various completion sources.

local loong = require("core.loong")

loong.add_plugin(
  -- Auto completion
  -- https://github.com/saghen/blink.cmp
  -- https://cmp.saghen.dev/installation
  "saghen/blink.cmp",
  {

    -- optional: provides snippets for the snippet source
    dependencies = {
      "rafamadriz/friendly-snippets",
      "Kaiser-Yang/blink-cmp-avante", -- use for anante.nvim complation
    },

    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = "enter" },

      -- disable cmdline
      cmdline = { enabled = false },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        -- default = { 'avante', 'lsp', 'path', 'snippets', 'buffer' },
        -- promblem for avante, ref:
        --   https://github.com/Kaiser-Yang/blink-cmp-avante/issues/7#issuecomment-2865110680
        default = function()
          local ft = vim.bo.filetype
          if ft == "DressingInput" then
            -- return { 'path', 'buffer' }
            return {}
          end
          local ss = { "lsp", "path", "snippets", "buffer" }
          if ft == "AvanteInput" then
            ss = { "avante" }
          elseif vim.tbl_contains({ "markdown", "Avante" }, vim.bo.filetype) then
            vim.list_extend(ss, { "buffer" }) -- , 'ripgrep', 'dictionary' })
          end
          return ss
        end,

        providers = {
          avante = {
            -- https://github.com/Kaiser-Yang/blink-cmp-avante?tab=readme-ov-file#lazynvim
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {},
          },
        },
      },
      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  }
)

-- auto_suggestions
-- https://github.com/supermaven-inc/supermaven-nvim
loong.add_plugin("supermaven-inc/supermaven-nvim", {
  -- enabled = false,
  opts = {
    ignore_filetypes = { "Avante", "TelescopePrompt" },
  },
})

-- avante
-- https://github.com/yetone/avante.nvim
loong.add_plugin("yetone/avante.nvim", {
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    selector = { provider = "snacks" },
    -- provider = "uni",
    provider = "gemini",
    cursor_applying_provider = "grop_lm3370bv",
    behaviour = {
      enable_cursor_planning_mode = true, -- https://github.com/yetone/avante.nvim/blob/main/cursor-planning-mode.md
      auto_suggestions = false,
      enable_token_counting = true,
      use_cwd_as_project_root = true,
    },
    providers = {
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        extra_request_body = {
          temperature = 0,
          max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
          --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
        },
      },
      gemini = {
        model = "gemini-2.5-pro",
        -- model = 'gemini-2.5-flash'
      },
      ds_reasoner = {
        __inherited_from = "or_dsv3",
        api_key_name = "DEEPSEEK_API_KEY",
        endpoint = "https://api.deepseek.com",
        model = "deepseek-reasoner",
        disable_tools = true,
      },
      ds_chat = {
        __inherited_from = "openai",
        api_key_name = "DEEPSEEK_API_KEY",
        endpoint = "https://api.deepseek.com",
        model = "deepseek-chat",
        disable_tools = true,
      },
      uni = {
        __inherited_from = "openai",
        api_key_name = "UNI_API_KEY",
        endpoint = "https://api.uniapi.io",
        model = "claude-sonnet-4-20250514",
        -- model = 'claude-3-5-sonnet-latest',
        -- model = 'deepseek-reasoner',
        -- model = 'claude-3-7-sonnet-20250219',
        -- model = 'claude-3-5-sonnet-20250219',
        -- disable_tools = true,
      },
      grop_lm3370bv = {
        __inherited_from = "openai",
        api_key_name = "GROQ_API_KEY",
        endpoint = "https://api.groq.com/openai/v1/",
        model = "llama-3.3-70b-versatile",
        extra_request_body = {
          max_completion_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
        },
      },
      groq_qwq = {
        __inherited_from = "openai",
        api_key_name = "GROQ_API_KEY",
        endpoint = "https://api.groq.com/openai/v1/",
        model = "qwen-qwq-32b",
        extra_request_body = {
          max_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
        },
        disable_tools = true,
      },
      or_dsv3 = {
        __inherited_from = "openai",
        endpoint = "https://openrouter.ai/api/v1",
        api_key_name = "OPENROUTER_API_KEY",
        model = "deepseek/deepseek-chat-v3-0324:free",
      },
      or_dsr1 = {
        __inherited_from = "openai",
        endpoint = "https://openrouter.ai/api/v1",
        api_key_name = "OPENROUTER_API_KEY",
        model = "deepseek/deepseek-r1:free",
      },
    },
    web_search_engine = {
      provider = "tavily", -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
      proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
    },
    windows = {
      position = "smart",
      height = 46,
      wrap = true,
      sidebar_header = { align = "center" },
      ask = { floating = false },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    { "echasnovski/mini.pick", config = true }, -- for file_selector provider mini.pick
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      ---@type snacks.Config
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = false },
        dashboard = { enabled = false },
        explorer = { enabled = false },
        indent = { enabled = true },
        input = { enabled = false },
        picker = { enabled = true },
        notifier = { enabled = false },
        quickfile = { enabled = false },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = { file_types = { "markdown", "Avante" } },
      ft = { "markdown", "Avante" },
    },
  },
})
