-- ============================================================
-- 高亮光标下的词（vim-illuminate）
-- ============================================================
return {
  {
    'RRethy/vim-illuminate',
    event = 'BufReadPre',
    config = function()
      require('illuminate').configure({})
    end,
  },
}