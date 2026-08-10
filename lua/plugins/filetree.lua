-- ============================================================
-- 文件树 nvim-tree
-- ============================================================
return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = function()
      require('nvim-tree').setup({
        view = { width = 32 },
        renderer = { group_empty = true },
        filters = { dotfiles = false },
      })
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end,
  },
}
