-- ============================================================
-- 注释切换（Comment.nvim）
-- gc 注释/取消注释
-- ============================================================
return {
  {
    'numToStr/Comment.nvim',
    event = 'BufReadPre',
    config = function()
      require('Comment').setup()
    end,
  },
}