-- ============================================================
-- TODO/FIXME 注释高亮（todo-comments）
-- 高亮代码中的 TODO/FIXME/HACK/WARN 注释
-- ]t / [t 跳转，<leader>t 打开列表
-- ============================================================
return {
  {
    'folke/todo-comments.nvim',
    event = 'BufReadPre',
    config = function()
      require('todo-comments').setup({})
    end,
  },
}