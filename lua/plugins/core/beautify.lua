-- ============================================================
-- 美化：标签栏 / 快捷键提示 / 通知 / 缩进参考线
-- ============================================================
return {
  -- 标签栏
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    config = function()
      require('bufferline').setup({
        options = {
          diagnostics = 'nvim_lsp',
          offsets = { { filetype = 'NvimTree', text = 'File Explorer', highlight = 'Directory' } },
        },
      })
    end,
  },
  -- 快捷键提示
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('which-key').setup({})
    end,
  },
  -- 通知美化（已移除：nvim-notify 与 Neovim 0.12 存在兼容性 bug，改用默认通知）
  -- 缩进参考线
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    config = function()
      require('ibl').setup({})
    end,
  },
}
