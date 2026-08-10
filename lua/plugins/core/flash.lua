-- ============================================================
-- 快速跳转（flash.nvim）
-- s 跳转 / S treesitter 搜索
-- ============================================================
return {
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    config = function()
      require('flash').setup()
      vim.keymap.set('n', 's', require('flash').jump, { desc = 'Flash' })
      vim.keymap.set('n', 'S', require('flash').treesitter_search, { desc = 'Flash Treesitter' })
    end,
  },
}