-- ============================================================
-- Mason：LSP / formatter / linter 自动安装（零配置核心）
-- 首次启动自动下载工具，装好后现有 executable() 检测自动通过
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
  -- formatter / linter 自动安装（registry 包名）
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
        run_on_start = true,
      })
    end,
  },
  -- LSP server 自动安装（lspconfig server 名）
  -- automatic_enable = false：只负责安装，启用仍由 lsp.lua 的 executable 检测决定
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'mason-org/mason.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'basedpyright', 'lua_ls', 'bashls', 'ts_ls', 'jsonls', 'yamlls',
        },
        automatic_enable = false,
      })
    end,
  },
}
