-- ============================================================
-- Mason：LSP / formatter / linter 工具管理
-- 工具按需安装；装好后现有 executable() 检测自动通过
-- 依赖：Windows 需 pwsh/Git/tar/7zip；npm 包需 Node（:checkhealth mason 验证）
-- ============================================================
return {
  -- 工具安装器本体
  {
    'mason-org/mason.nvim',
    build = ':MasonUpdate',  -- 更新 registry
    config = function()
      require('mason').setup()
    end,
  },
  -- formatter / linter 工具清单（registry 包名）
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
      require('mason-tool-installer').setup({
        ensure_installed = {
          -- formatter
          'stylua', 'shfmt', 'ruff', 'prettierd',
          -- linter
          'shellcheck',
        },
        -- 需要工具时执行 :MasonToolsInstall
      })
    end,
  },
}
