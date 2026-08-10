-- ============================================================
-- LSP 支持
-- 使用 uv 安装的服务器，不通过 mason 下载
-- Python: basedpyright（uv tool install）
-- ruff 由 conform/nvim-lint 调用系统 ruff
-- ============================================================
return {
  -- LSP 配置
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- Python：使用 uv 安装的 basedpyright（新版 nvim-lspconfig API）
      vim.lsp.config('basedpyright', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })
      vim.lsp.enable('basedpyright')

      -- LSP 快捷键
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }
      map('n', 'gd', vim.lsp.buf.definition, opts)
      map('n', 'K', vim.lsp.buf.hover, opts)
      map('n', 'gi', vim.lsp.buf.implementation, opts)
      map('n', 'gr', vim.lsp.buf.references, opts)
      map('n', '<leader>rn', vim.lsp.buf.rename, opts)
      map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      map('n', '<leader>d', vim.diagnostic.open_float, opts)
      map('n', '[d', vim.diagnostic.goto_prev, opts)
      map('n', ']d', vim.diagnostic.goto_next, opts)
    end,
  },
}