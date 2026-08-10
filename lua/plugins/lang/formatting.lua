-- ============================================================
-- 格式化 (conform) + Lint (nvim-lint)
-- Python: ruff（系统已安装）| Lua: stylua
-- ============================================================
return {
  -- 格式化
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          python = { 'ruff_format' },
          lua = { 'stylua' },
        },
        format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
      })
    end,
  },
  -- Lint
  {
    'mfussenegger/nvim-lint',
    event = 'BufWritePost',
    config = function()
      require('lint').linters_by_ft = {
        python = { 'ruff' },
      }
    end,
  },
}