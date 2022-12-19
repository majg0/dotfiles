local map = vim.keymap.set
local opt = { noremap = true }

-- Core
map('n', '<up>', '<nop>', opt)
map('n', '<down>', '<nop>', opt)
map('n', '<left>', '<nop>', opt)
map('n', '<right>', '<nop>', opt)
map('n', '<esc>', '<cmd>nohls<cr>', opt)

-- Window navigation
map('n', '<C-h>', '<C-w>h', opt)
map('n', '<C-j>', '<C-w>j', opt)
map('n', '<C-k>', '<C-w>k', opt)
map('n', '<C-l>', '<C-w>l', opt)

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opt)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opt)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opt)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opt)

-- NvimTree
map('n', '<leader>t', '<cmd>NvimTreeToggle<cr>', opt)
