-- ============================================================
-- 主题（替代默认主题）
-- ============================================================
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,          -- 主题需最先加载
    lazy = false,
    opts = {
      flavour = 'mocha',      -- 深色系，Windows Terminal 适配好
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme('catppuccin')
    end,
  },
}
