-- ============================================================
-- 包围符号（nvim-surround）
-- ys 添加 / ds 删除 / cs 修改
-- ============================================================
return {
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup({})
    end,
  },
}