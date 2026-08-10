-- ============================================================
-- 快捷键
-- ============================================================
vim.g.mapleader = ','          -- 沿用原配置的 leader 键

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 保存 / 退出
map('n', '<leader>w', ':w<CR>', opts)
map('n', '<leader>q', ':q<CR>', opts)
map('n', '<leader>wq', ':wq<CR>', opts)

-- 分屏导航（Ctrl + hjkl）
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- 取消搜索高亮
map('n', '<Esc>', ':nohlsearch<CR>', opts)

-- 粘贴模式切换（F3）
map('n', '<F3>', ':set paste!<CR>', opts)

-- Telescope 快捷键（如果 telescope 已配置）
map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
map('n', '<leader>fb', ':Telescope buffers<CR>', opts)
