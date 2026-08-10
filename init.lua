-- ============================================================
-- nvim 入口 (Windows)
-- 位置: %LOCALAPPDATA%\nvim\init.lua
-- 基于 lazy.nvim 插件管理器
-- ============================================================

-- 加载基础配置
require('config.options')
require('config.keymaps')

-- 引导 lazy.nvim（首次自动克隆）
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 加载插件（lua/plugins/ 目录下每个文件一个插件）
require('lazy').setup('plugins', {
  checker = { enabled = true },   -- 启动时检查插件更新
  change_detection = { notify = false },
})