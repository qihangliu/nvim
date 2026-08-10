-- ============================================================
-- 启动页（dashboard-nvim）
-- doom 主题，使用插件内置 ASCII art header
-- ============================================================
return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('dashboard').setup({
        theme = 'doom',
        hide = {
          statusline = true,
          tabline = true,
          winbar = true,
        },
        config = {
          -- 不设置 header，使用插件内置 ASCII art
          center = {
            {
              icon = ' ',
              desc = 'Find File',
              key = 'f',
              keymap = ',ff',
              action = function()
                require('telescope.builtin').find_files()
              end,
            },
            {
              icon = ' ',
              desc = 'Recent Files',
              key = 'r',
              keymap = ',fr',
              action = function()
                require('telescope.builtin').oldfiles()
              end,
            },
            {
              icon = ' ',
              desc = 'Live Grep',
              key = 'g',
              keymap = ',fg',
              action = function()
                require('telescope.builtin').live_grep()
              end,
            },
            {
              icon = ' ',
              desc = 'Quit',
              key = 'q',
              action = 'qa',
            },
          },
          footer = { '', '跨平台 Nvim 配置' },
          vertical_center = true,
        },
      })
    end,
  },
}