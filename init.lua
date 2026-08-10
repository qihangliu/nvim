-- ============================================================
-- nvim 入口（跨平台通用）
-- 位置: %LOCALAPPDATA%\nvim\init.lua (Windows)
--       ~/.config/nvim/init.lua        (Linux/macOS)
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

-- 插件加载：
--   plugins/core/  通用插件（默认加载，跨平台跨语言）
--   plugins/lang/  语言相关插件（LSP/格式化/lint，按需启用）
require('lazy').setup({
  { import = 'plugins.core' },
  -- 按需启用语言支持（LSP、格式化、lint）：
  -- 取消注释下面一行，并在对应系统安装所需工具
  -- （如 basedpyright、ruff、stylua），详见 lua/plugins/lang/ 内注释
  -- { import = 'plugins.lang' },
}, {
  checker = { enabled = true },   -- 启动时检查插件更新
  change_detection = { notify = false },
})