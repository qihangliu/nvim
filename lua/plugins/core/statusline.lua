-- ============================================================
-- 状态栏（lualine）
-- ============================================================
return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    config = function()
      require('lualine').setup({
        options = {
          theme = 'catppuccin',  -- lualine 内置 catppuccin 主题（不依赖 catppuccin utils）
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      })
    end,
  },
}