-- Manages configurations for plugins that improve the core text editing experience.
-- Covers text manipulation, movement, commenting, and structural editing.
local loong = require('core.loong')

loong.add_plugin(
  -- file explor
  -- https://github.com/nvim-tree/nvim-tree.lua
  'nvim-tree/nvim-tree.lua',
  {
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup({
        ---### ahmedkhalf/project.nvim dependencies ---
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
      })
      require('which-key').add({
        { '<leader>ft', '<cmd>NvimTreeToggle<cr>', desc = 'Open NvimTree', mode = 'n' },
      })
    end,
  }
)

-- fotmat
-- https://github.com/stevearc/conform.nvim
loong.add_plugin('stevearc/conform.nvim', {
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
})
-- search
-- https://github.com/nvim-telescope/telescope.nvim
loong.add_plugin('nvim-telescope/telescope.nvim', {
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
})

-- project
-- https://github.com/ahmedkhalf/project.nvim
loong.add_plugin('ahmedkhalf/project.nvim', {
  config = function()
    require('project_nvim').setup({
      exclude_dirs = { '*//*' },
      detection_methods = { 'pattern' },
      patterns = { '.git' },
    })
  end,
})

loong.add_plugin('towolf/vim-helm', {
  ft = 'helm',
  config = function()
    vim.filetype.add({
      pattern = {
        -- Chart.yaml
        ['Chart.yaml'] = 'helm',
        ['values.yaml'] = 'helm',
        ['.*templates/.*%.yaml'] = 'helm',
        ['.*templates/.*%.yml'] = 'helm',
      },
    })
  end,
})

--- Treesitter
--- https://github.com/nvim-treesitter/nvim-treesitter
loong.add_plugin('nvim-treesitter/nvim-treesitter', {
  build = function()
    if #vim.api.nvim_list_uis() ~= 0 then
      vim.cmd('TSUpdate')
    end
  end,
  event = { 'BufRead', 'BufNewFile' },
  config = function()
    local treesitter = require('nvim-treesitter.configs')
    treesitter.setup({
      -- indent = { enable = true },
      sync_install = false,
      -- ensure_installed = 'all',
      ensure_installed = {
        'lua',
        'markdown',
        'json',
        'yaml',
        'toml',
        'html',
        'css',
        'javascript',
        'typescript',
        'c',
        'cpp',
        'python',
        'rust',
        'go',
      },
      auto_install = false,
      -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#modules
      highlight = {
        -- `false` will disable the whole extension
        -- enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
      },
    })
  end,
})

-- terminal
-- toggleterm.setup()
-- https://github.com/akinsho/toggleterm.nvim
loong.add_plugin('akinsho/toggleterm.nvim', {
  branch = 'main',
  event = 'BufRead',
  config = function()
    require('toggleterm').setup({
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
    })

    require('which-key').add({
      { "<leader>'", '<cmd>exe v:count1 . "ToggleTerm"<CR>', desc = 'Open shell', mode = 'n' },
    })
  end,
})

-- code navigation
-- https://github.com/folke/flash.nvim
loong.add_plugin('folke/flash.nvim', {
  event = 'VeryLazy',
  opts = {},
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    {
      'S',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Treesitter Search',
    },
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  },
})

-- markdown
-- https://github.com/MeanderingProgrammer/render-markdown.nvim
loong.add_plugin('MeanderingProgrammer/render-markdown.nvim', {
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  ft = { 'markdown', 'Avante', 'vimwiki' },
  config = function()
    require('render-markdown').setup({
      completions = { blink = { enabled = true } },
      file_types = { 'markdown', 'vimwiki', 'Avante' },
    })
  end,
})
