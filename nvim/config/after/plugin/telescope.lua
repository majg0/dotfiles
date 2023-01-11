require('telescope').load_extension('fzf')

local builtin = require 'telescope.builtin'
local opt = {}

vim.keymap.set('n', '<leader>fw', builtin.find_files, opt) -- Find in Working directory
vim.keymap.set('n', '<leader>fr', builtin.git_files, opt) -- Find in Repository
vim.keymap.set('n', '<leader>fg', builtin.live_grep, opt) -- Find using Grep
vim.keymap.set('n', '<leader>fb', builtin.buffers, opt) -- Find Buffer
vim.keymap.set('n', '<leader>fh', builtin.help_tags, opt) -- Find Help
