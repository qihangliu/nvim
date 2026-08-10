-- ============================================================
-- Treesitter 语法高亮
-- 固定 master 分支（旧版稳定版）：本机用 zig 作为 C 编译器
-- 新版 (main) 需要 tree-sitter-cli，本机未安装
-- ============================================================
return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',  -- 旧版稳定分支，支持 zig 编译解析器
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'python', 'bash', 'lua', 'vim', 'vimdoc', 'markdown', 'json', 'yaml', 'toml' },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })

      -- Windows 修复：master 分支编译出 .so，但 Neovim 在 Windows 上需要 .dll 才能加载解析器
      -- 在解析器安装/更新后把 .so 复制为同名 .dll（仅 Windows 生效，Linux 解析器本就是 .so）
      if vim.fn.has('win32') == 1 then
        local function fix_parser_dlls()
          local dirs = {}
          local ok, dir = pcall(require('nvim-treesitter.configs').get_parser_install_dir)
          if ok and dir and dir ~= '' then
            dirs[#dirs + 1] = dir
          end
          local plugin_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy', 'nvim-treesitter', 'parser')
          if vim.fn.isdirectory(plugin_dir) == 1 then
            dirs[#dirs + 1] = plugin_dir
          end
          for _, d in ipairs(dirs) do
            for _, so in ipairs(vim.fn.glob(vim.fs.joinpath(d, '*.so'), false, true)) do
              local dll = so:gsub('%.so$', '.dll')
              if vim.fn.filereadable(dll) == 0 then
                vim.uv.fs_copyfile(so, dll)
              end
            end
          end
        end

        fix_parser_dlls()
        vim.api.nvim_create_autocmd({ 'FileType', 'BufReadPost' }, {
          group = vim.api.nvim_create_augroup('TreesitterDllFix', { clear = true }),
          callback = fix_parser_dlls,
        })
      end
    end,
  },
}
