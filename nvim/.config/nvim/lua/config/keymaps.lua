--- =eeeee===========================
--- Local keymaps
--- ============================

local map = vim.keymap.set

-- Buffer Navigatio
map('n', '<leader>bn', ':bnext<CR>') -- Next buffer
map('n', '<leader>bp', ':bprevious<CR>') -- Prev buffer
map('n', '<leader>bb', ':e #<CR>') -- Switch to Other Buffer
map('n', '<leader>`', ':e #<CR>') -- Switch to Other Buffer

map('n', '<leader>e', ':NvimTreeToggle<CR>') -- Switch to Other Buffer
