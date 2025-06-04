local map = vim.keymap.set

map('i', '<C-b>', '<ESC>^i', { desc = 'move beginning of line' })
map('i', '<C-e>', '<End>', { desc = 'move end of line' })
map('i', '<C-h>', '<Left>', { desc = 'move left' })
map('i', '<C-l>', '<Right>', { desc = 'move right' })
map('i', '<C-j>', '<Down>', { desc = 'move down' })
map('i', '<C-k>', '<Up>', { desc = 'move up' })

-- Window
-- map('n', '<C-h>', '<C-w>h', { desc = 'switch window left' })
-- map('n', '<C-l>', '<C-w>l', { desc = 'switch window right' })
-- map('n', '<C-j>', '<C-w>j', { desc = 'switch window down' })
-- map('n', '<C-k>', '<C-w>k', { desc = 'switch window up' })

map('n', '<leader>1', '1<C-w><C-w>', { desc = 'Select window 1' })
map('n', '<leader>2', '2<C-w><C-w>', { desc = 'Select window 2' })
map('n', '<leader>3', '3<C-w><C-w>', { desc = 'Select window 3' })
map('n', '<leader>4', '4<C-w><C-w>', { desc = 'Select window 4' })
map('n', '<leader>5', '5<C-w><C-w>', { desc = 'Select window 5' })
map('n', '<leader>6', '6<C-w><C-w>', { desc = 'Select window 6' })

map('n', '<C-Up>', ':resize +2<CR>')
map('n', '<C-Down>', ':resize -2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '<C-Right>', ':vertical resize +2<CR>')

map('n', '<leader>ws', '<C-w>s', { desc = 'Split window below' })
map('n', '<leader>wv', '<C-w>v', { desc = 'Split window right' })
map('n', '<leader>w-', '<C-w>s', { desc = 'Split window below' })
map('n', '<leader>w/', '<C-w>v', { desc = 'Split window right' })
map('n', '<leader>ww', '<C-w>w', { desc = 'Other window' })
map('n', '<leader>wj', '<C-w>j', { desc = 'Go to the down window' })
map('n', '<leader>wk', '<C-w>k', { desc = 'Go to the up window' })
map('n', '<leader>wh', '<C-w>h', { desc = 'Go to the left window' })
map('n', '<leader>wl', '<C-w>l', { desc = 'Go to the right window' })
map('n', '<leader>wd', '<C-w>c', { desc = 'Delete window' })
map('n', '<leader>wm', '<C-w>o', { desc = 'Maximize window' })

-- Buffer
map('n', '<leader><Tab>', ':b#<CR>', { desc = 'Last buffer' })

-- jump
map('n', '<leader>jj', '<cmd>lua require("flash").remote()<cr>', { desc = 'Jump to a char' })
map('v', '<leader>jj', '<cmd>lua require("flash").remote()<cr>')
map(
  'n',
  '<leader>jl',
  '<cmd>lua require("flash").jump({ search = { mode = "search", max_length = 0 }, label = { after = { 0, 0 } }, pattern = "^" })<cr>',
  { desc = 'Jump to a line' }
)
map(
  'n',
  '<leader>ji',
  '<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>',
  { desc = 'Jump to a symbol' }
)
