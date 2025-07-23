local loong = require('core.loong')

loong.add_plugin('tanvirtin/monokai.nvim', {
  lazy = false,
  priority = 1000,
  config = function()
    require('monokai').setup({
      -- dark_variant = "darker",
      -- palette = {
      --   red = '#FF5555',
      --   green = '#50FA7B',
      -- },
      -- https://github.com/tanvirtin/monokai.nvim#configuration
    })
    vim.cmd.colorscheme('monokai')
  end,
})
