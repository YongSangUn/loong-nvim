return {
  -- show keybindings in popup.
  -- https://github.com/folke/which-key.nvim
  {
    'folke/which-key.nvim',
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
        { '<leader>1', '1<C-w><C-w>', desc = 'Select Window 1', mode = 'n' },
        { '<leader>2', '2<C-w><C-w>', desc = 'Select Window 2', mode = 'n' },
        { '<leader>3', '3<C-w><C-w>', desc = 'Select Window 3', mode = 'n' },
        { '<leader>4', '4<C-w><C-w>', desc = 'Select Window 4', mode = 'n' },
        { '<leader>5', '5<C-w><C-w>', desc = 'Select Window 5', mode = 'n' },
        { '<leader>6', '6<C-w><C-w>', desc = 'Select Window 6', mode = 'n' },
      })
    end,
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },

  -- scrollo
  -- https://github.com/karb94/neoscroll.nvim
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup({})
    end,
  },
  -- file explor
  -- https://github.com/nvim-tree/nvim-tree.lua
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      config = function()
        require('nvim-tree').setup({
          ---### ahmedkhalf/project.nvim dependencies ---
          sync_root_with_cwd = true,
          respect_buf_cwd = true,
          update_focused_file = {
            enable = true,
            update_root = true,
          },
          ---### ahmedkhalf/project.nvim dependencies ---
          -- actions = {
          --   open_file = {
          --     update_focused_file = {
          --       enable = true,
          --       update_root = true,
          --     },
          --   },
          -- },
        })
        require('which-key').add({
          { '<leader>ft', '<cmd>NvimTreeToggle<cr>', desc = 'Open NvimTree', mode = 'n' },
        })
      end,
    },
  },

  -- Auto completion
  -- https://github.com/saghen/blink.cmp
  -- https://cmp.saghen.dev/installation
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      'rafamadriz/friendly-snippets',
      'Kaiser-Yang/blink-cmp-avante', -- use for anante.nvim complation
    },

    -- use a release tag to download pre-built binaries
    version = '1.*',
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
      -- keymap = { preset = 'default' },
      keymap = {
        -- preset = 'enter',
        -- Select completions
        -- ['<Tab>'] = { 'select_next', 'fallback' },
        -- ['<S-Tab>'] = { 'select_prev', 'fallback' },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        -- The keyword should only match against the text before
        keyword = { range = 'prefix' },
        menu = {
          -- Use treesitter to highlight the label text for the given list of sources
          draw = {
            treesitter = { 'lsp' },
          },
        },
        -- Show completions after typing a trigger character, defined by the source
        trigger = { show_on_trigger_character = true },
        documentation = {
          -- Show documentation automatically
          auto_show = true,
        },
      },
      -- completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'avante', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
            opts = {
              -- options for blink-cmp-avante
            },
          },
        },
      },
      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },

  -- LSP manager
  { 'mason-org/mason.nvim', opts = {} },

  -- handle the inconsistent naming issue between mason.nvim and nvim-lspconfig.
  -- https://github.com/mason-org/mason-lspconfig.nvim
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      ensure_installed = {
        'ruff', -- "black", "isort",
        'lua_ls', -- "stylua",
        'gopls', -- "goimports", "gofmt",
        -- "rustfmt",
        -- "shfmt",
        -- "codespell",
        -- "trim_whitespace",
      },
    },
  },

  -- Quickstart configs for Nvim LSP
  -- https://github.com/neovim/nvim-lspconfig
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.ruff.setup({})
      lspconfig.lua_ls.setup({})
      lspconfig.gopls.setup({})
    end,
  },

  -- fotmat
  -- https://github.com/stevearc/conform.nvim
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('which-key').add({
        {
          '<leader>fp',
          function()
            require('conform').format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
          end,
          desc = 'Format File',
          mode = 'n',
        },
      })
      require('conform').setup({
        default_format_opts = {
          lsp_format = 'fallback',
        },
        formatters_by_ft = {
          lua = { 'stylua' },
          go = { 'goimports', 'gofmt' },
          rust = { 'rustfmt', lsp_format = 'fallback' },
          sh = { 'shfmt' },
          python = function(bufnr)
            if require('conform').get_formatter_info('ruff_format', bufnr).available then
              return { 'ruff_format' }
            else
              return { 'isort', 'black' }
            end
          end,
          ['*'] = { 'codespell' },
          ['_'] = { 'trim_whitespace' },
        },
        -- format_on_save = {
        -- 	lsp_fallback = true,
        -- 	async = false,
        -- 	timeout_ms = 500,
        -- },
        formatters = {
          injected = { options = { ignore_errors = true } },
          shfmt = {
            prepend_args = { '-i', '2', '-ci' },
          },
          stylua = {
            args = {
              '--indent-width',
              '2',
              '--indent-type',
              'Spaces',
              '--quote-style',
              'AutoPreferSingle',
              '-',
            },
            black = {
              args = { '--line-length', '120', '-' },
            },
          },
        },
        keys = {},
      })
    end,
  },

  -- Indent Blankline
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function()
      require('ibl').setup()
    end,
  },

  -- dashboard
  -- https://github.com/nvimdev/dashboard-nvim
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup({
        -- config
      })
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },

  -- search
  -- https://github.com/nvim-telescope/telescope.nvim
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', lazy = true },
      {
        'nvim-telescope/telescope-project.nvim',
        dependencies = {
          'nvim-telescope/telescope.nvim',
        },
      },
    },
    config = function()
      require('which-key').add({
        { '<leader>pp', '<cmd>Telescope projects<cr>', desc = 'List Projects', mode = 'n' },
        { '<leader>pf', '<cmd>Telescope find_files<cr>', desc = 'List Project files', mode = 'n' },
        { '<leader>/', '<cmd>Telescope live_grep<cr>', desc = 'Search text in current project', mode = 'n' },
      })
      require('telescope').setup({})
      require('telescope').load_extension('project')
    end,
  },

  -- project
  -- https://github.com/ahmedkhalf/project.nvim
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup({
        exclude_dirs = { '*//*' },
        detection_methods = { 'pattern' },
        patterns = { '.git' },
      })
    end,
  },

  -- git
  -- https://github.com/NeogitOrg/neogit
  {
    'NeogitOrg/neogit',
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
  },

  -- auto_suggestions
  -- https://github.com/supermaven-inc/supermaven-nvim
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup({
        ignore_filetypes = { 'Avante', 'TelescopePrompt' },
      })
    end,
  },

  -- avante
  -- https://github.com/yetone/avante.nvim
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    opts = {
      -- provider = 'or_dsv3',
      provider = 'gemini',
      cursor_applying_provider = 'grop_lm3370bv',
      behaviour = {
        enable_cursor_planning_mode = true, -- https://github.com/yetone/avante.nvim/blob/main/cursor-planning-mode.md
        auto_suggestions = false,
        enable_token_counting = true,
        use_cwd_as_project_root = true,
      },
      openai = {
        endpoint = 'https://api.openai.com/v1',
        model = 'gpt-4o', -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        temperature = 0,
        max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      },
      gemini = {
        model = 'gemini-2.5-flash-preview-05-20',
        -- model = 'gemini-2.5-pro-preview-05-06',
        -- model = 'gemini-2.5-pro-preview-03-25',
        -- model = 'gemini-2.5-pro-exp-03-25',
        -- model = 'gemini-2.0-flash-exp',
        -- model = 'gemini-2.0-pro-exp',
        -- model = 'gemini-2.0-flash-thinking-exp-1219',
      },
      vendors = {
        ds_r1 = {
          __inherited_from = 'or_dsv3',
          api_key_name = 'DEEPSEEK_API_KEY',
          endpoint = 'https://api.deepseek.com',
          model = 'deepseek-reasoner',
          disable_tools = true,
        },
        ds_v3 = {
          __inherited_from = 'openai',
          api_key_name = 'DEEPSEEK_API_KEY',
          endpoint = 'https://api.deepseek.com',
          model = 'deepseek-chat',
          disable_tools = true,
        },
        uni = {
          __inherited_from = 'openai',
          api_key_name = 'UNI_API_KEY',
          endpoint = 'https://api.uniapi.io',
          model = 'claude-sonnet-4-20250514',
          -- model = 'claude-3-5-sonnet-latest',
          -- model = 'deepseek-reasoner',
          -- model = 'claude-3-7-sonnet-20250219',
          -- model = 'claude-3-5-sonnet-20250219',
          -- disable_tools = true,
        },
        grop_lm3370bv = {
          __inherited_from = 'openai',
          api_key_name = 'GROQ_API_KEY',
          endpoint = 'https://api.groq.com/openai/v1/',
          model = 'llama-3.3-70b-versatile',
          max_completion_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
        },
        groq_qwq = {
          __inherited_from = 'openai',
          api_key_name = 'GROQ_API_KEY',
          endpoint = 'https://api.groq.com/openai/v1/',
          model = 'qwen-qwq-32b',
          max_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
          disable_tools = true,
        },
        or_dsv3 = {
          __inherited_from = 'openai',
          endpoint = 'https://openrouter.ai/api/v1',
          api_key_name = 'OPENROUTER_API_KEY',
          model = 'deepseek/deepseek-chat-v3-0324:free',
        },
        or_dsr1 = {
          __inherited_from = 'openai',
          endpoint = 'https://openrouter.ai/api/v1',
          api_key_name = 'OPENROUTER_API_KEY',
          model = 'deepseek/deepseek-r1:free',
        },
      },
      web_search_engine = {
        provider = 'tavily', -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
        proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
      },
      -- selector = {
      --   provider = 'telescope',
      -- },
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'echasnovski/mini.pick', -- for file_selector provider mini.pick
      'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
      'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
      'ibhagwan/fzf-lua', -- for file_selector provider fzf
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
}
