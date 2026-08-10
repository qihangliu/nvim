-- ============================================================
-- 格式化 (conform) + Lint (nvim-lint)（自动检测）
-- Python: ruff（系统已安装）| Lua: stylua
-- 系统未安装对应工具时自动禁用，不报错
-- ============================================================
return {
  -- 格式化
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    enabled = vim.fn.executable('ruff') == 1 or vim.fn.executable('stylua') == 1,
    config = function()
      -- 动态构建 formatters_by_ft，只包含已安装的工具
      local formatters_by_ft = {}
      if vim.fn.executable('ruff') == 1 then
        formatters_by_ft.python = { 'ruff_format' }
      end
      if vim.fn.executable('stylua') == 1 then
        formatters_by_ft.lua = { 'stylua' }
      end
      require('conform').setup({
        formatters_by_ft = formatters_by_ft,
        format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
      })
    end,
  },
  -- Lint
  {
    'mfussenegger/nvim-lint',
    event = 'BufWritePost',
    enabled = vim.fn.executable('ruff') == 1,
    config = function()
      local linters_by_ft = {}
      if vim.fn.executable('ruff') == 1 then
        linters_by_ft.python = { 'ruff' }
      end
      require('lint').linters_by_ft = linters_by_ft
    end,
  },
}