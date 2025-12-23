# Loong.nvim

A modern, modular Neovim configuration built with Lua, leveraging Neovim 0.11+ features for enhanced LSP support and a streamlined development experience.

## 🌟 Features

### Core Architecture

- **Modular Design**: Organized into logical layers (`theme`, `editor`, `lsp`, `completion`, `git`, `ui`)
- **Plugin Management**: Powered by [lazy.nvim](https://github.com/folke/lazy.nvim) for efficient plugin loading
- **Custom Configuration System**: Centralized plugin and LSP management through `lua/core/loong.lua`

### Language Server Protocol (LSP)

- **Neovim 0.11+ Integration**: Utilizes native LSP capabilities with `vim.lsp.enable()`
- **Custom LSP Configs**: Modular LSP configurations in `lsp/` directory
- **Automatic Installation**: Mason integration for seamless LSP server installation
- **Smart Formatting**: Conform.nvim integration with filetype-specific formatters
- **Custom Filetypes**: Support for custom filetypes like `azure-pipelines`, `helm`

### Code Intelligence

- **Modern Completion**: Blink.cmp for fast, efficient code completion
- **AI Integration**: Avante.nvim with multiple AI providers (OpenAI, DeepSeek, Moonshot, Claude, etc.)
- **MCP Support**: Model Context Protocol integration via mcphub.nvim
- **Auto-suggestions**: Supermaven integration for intelligent code suggestions

### Editor Enhancements

- **File Management**: Nvim-tree for file exploration
- **Fuzzy Finding**: Telescope integration with project management
- **Code Navigation**: Flash.nvim for lightning-fast movement
- **Terminal Integration**: Toggleterm for seamless terminal access
- **Treesitter**: Advanced syntax highlighting and parsing

### Git Integration

- **Git Signs**: Real-time git status indicators
- **Blame View**: Inline and window-based git blame
- **Diff View**: Comprehensive diff viewing capabilities
- **Neogit**: Magit-inspired git interface

### UI/UX

- **Modern Interface**: Clean, functional UI with lualine and bufferline
- **Theme Support**: Monokai theme with custom highlights
- **Smooth Scrolling**: Enhanced navigation experience
- **Dashboard**: Custom startup dashboard with quick actions

## 📁 Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── core/
│   │   ├── init.lua           # Core initialization
│   │   ├── loong.lua          # Main configuration system
│   │   ├── options.lua        # Neovim options
│   │   ├── keymaps.lua        # Key mappings
│   │   └── filetype.lua       # Filetype configurations
│   └── layers/                # Modular plugin configurations
│       ├── theme.lua          # Theme and colorscheme
│       ├── editor.lua         # Editor enhancements
│       ├── lsp.lua           # LSP and formatting
│       ├── completion.lua    # Completion and AI
│       ├── git.lua           # Git integration
│       └── ui.lua            # UI components
├── lsp/                       # LSP server configurations
│   ├── bashls.lua            # Bash language server
│   ├── lua_ls.lua            # Lua language server
│   ├── pylsp.lua             # Python language server
│   ├── ts_ls.lua             # TypeScript language server
│   └── ...                   # Other language servers
└── static/                    # Static assets
```

## 🚀 Installation

### Prerequisites

- Neovim 0.11+ (for native LSP support)
- Git
- Node.js and npm (for some LSP servers)
- Python (for some LSP servers)
- Go (for some LSP servers)

### Quick Start

1. **Backup your existing configuration**:

   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   ```

2. **Clone the repository**:

   ```bash
   git clone https://github.com/YongSangUn/loong-nvim.git ~/.config/nvim
   ```

3. **Start Neovim**:

   ```bash
   nvim
   ```

   Lazy.nvim will automatically install all plugins on first startup.

4. **Install LSP servers**:
   - Run `:Mason` to open the Mason interface
   - Install required LSP servers for your languages
   - Or let the automatic installation handle it based on your `lsp/` configurations

## ⚙️ Configuration

### Adding New LSP Servers

Simply create a new LSP configuration file in the `lsp/` directory:

```lua
-- lsp/myserver.lua
return {
  -- custom start --
  lsp_server = "my-language-server",  -- Mason package name (auto-installed)
  formatter = { "myformatter" },      -- Formatters (auto-installed)
  -- custom end --
  cmd = { "my-language-server", "start" },
  filetypes = { "myfiletype" },
  root_markers = { ".git" },
  settings = {
    -- LSP specific settings
  },
}
```

**The LSP server and formatters will be automatically installed by Mason.**

**Note**: Formatter configuration needs to be manually added to `lua/layers/lsp.lua` in the conform.nvim setup.

For custom filetypes, add them to `lua/core/filetype.lua` and update treesitter in `lua/layers/editor.lua` if needed.

### Custom Keymaps

Edit `lua/core/keymaps.lua` to add or modify key mappings:

```lua
local map = vim.keymap.set

-- Example: Custom save shortcut
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
```

### Plugin Configuration

Add new plugins in the appropriate layer file:

```lua
-- In lua/layers/editor.lua
loong.add_plugin("username/plugin-name", {
  event = "VeryLazy",
  opts = {
    -- Plugin options
  },
  keys = {
    { "<leader>xx", "<cmd>PluginCommand<cr>", desc = "Plugin action" }
  }
})
```

## 🔧 Key Features Explained

### LSP Configuration System

The configuration uses a sophisticated LSP management system:

- **Global Configuration**: Centralized in `lua/core/loong.lua`
- **Custom Defaults**: Each LSP can have custom settings
- **Automatic Installation**: Mason automatically installs LSP servers and formatters
- **Filetype Integration**: Custom filetypes automatically trigger appropriate LSP servers

### AI Integration

Avante.nvim provides multiple AI providers:

- **OpenAI**: GPT-4o and other models
- **DeepSeek**: Reasoning and chat models
- **Moonshot**: Kimi models
- **Claude**: Opus and Sonnet models
- **Gemini**: Google's models

### Formatting System

Conform.nvim handles formatting with:

- **Filetype-specific formatters**: Different formatters for different languages
- **LSP fallback**: Uses LSP formatting when dedicated formatters aren't available
- **Custom formatters**: Support for tools like `yamlfmt` with custom arguments

## 📋 Default Keymaps

Keymaps are configured in `lua/core/keymaps.lua`. The leader key is set to space. Refer to the keymaps file for the complete list of shortcuts.

## 🛠️ Troubleshooting

### LSP Not Working

1. Check if the LSP server is installed: `:Mason`
2. Verify the filetype is correctly detected: `:set filetype?`
3. Check LSP logs: `:LspInfo`

### Plugin Issues

1. Update plugins: `:Lazy update`
2. Clear plugin cache: `:Lazy clean`
3. Check plugin status: `:Lazy`

### Performance

1. Profile startup time: `:StartupTime`
2. Check for conflicting plugins
3. Disable unused features in plugin configurations

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This configuration is released under the MIT License. See LICENSE file for details.

## 🙏 Acknowledgments

- [Neovim](https://neovim.io/) for the amazing editor
- [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management
- [mason.nvim](https://github.com/mason-org/mason.nvim) for LSP server management
- All the plugin authors who make Neovim awesome

---

**Enjoy coding with Loong.nvim! 🐉**
