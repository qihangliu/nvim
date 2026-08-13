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

-- 取消搜索高亮（<C-l> 已被分屏导航占用，用 <leader>nh）
map('n', '<leader>nh', ':nohlsearch<CR>', opts)
-- Telescope 快捷键在 plugins/core/telescope.lua 中定义（单一来源）
