-- ============================================================
-- Treesitter 语法高亮（main 分支，Neovim 0.12+）
-- 依赖：tree-sitter-cli + C 编译器（zig/gcc/clang）
-- 跨平台：缺依赖时静默降级不报错；装齐后重启自动启用
-- ============================================================

-- 检测 C 编译器（编译 parser 必需）
local has_cc = vim.fn.executable('cc') == 1
  or vim.fn.executable('gcc') == 1
  or vim.fn.executable('clang') == 1
  or vim.fn.executable('zig') == 1

-- Windows + 仅有 zig 时：tree-sitter-cli 0.26 会硬编码传
-- `--target=x86_64-pc-windows-msvc`，而 zig 0.16 无法解析 `pc` vendor，
-- 且 msvc target 需要 Windows SDK。生成 zig-cc.cmd shim 把 target 重写为
-- windows-gnu，并设置 CC 环境变量让 tree-sitter 使用它。
if vim.fn.has('win32') == 1
  and vim.fn.executable('cc') == 0
  and vim.fn.executable('gcc') == 0
  and vim.fn.executable('clang') == 0
  and vim.fn.executable('zig') == 1
  and (vim.env.CC == nil or vim.env.CC == 'zig')
then
  local zig = vim.fn.exepath('zig')
  local shim = vim.fs.joinpath(vim.fn.stdpath('data'), 'zig-cc.cmd')
  local lines = {
    '@echo off',
    'set "args=%*"',
    'set "args=%args:pc-windows-msvc=windows-gnu%"',
    '"' .. zig .. '" cc %args%',
  }
  local f = io.open(shim, 'w')
  if f then
    f:write(table.concat(lines, '\r\n'))
    f:close()
    vim.env.CC = shim
  end
end
-- 检测 tree-sitter-cli（main 分支安装 parser 必需）
local has_ts_cli = vim.fn.executable('tree-sitter') == 1
local can_install = has_cc and has_ts_cli

local languages = { 'python', 'bash', 'lua', 'vim', 'vimdoc', 'markdown', 'json', 'yaml', 'toml' }

return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,  -- main 分支不支持懒加载
    build = can_install and ':TSUpdate' or nil,
    config = function()
      -- 回退：缺依赖时不安装 parser，降级到 Neovim 内置 parser（c/lua/vim/markdown 等），
      -- 仅提示一次（WARN，不刷屏）；装齐后重启自动启用
      if not can_install then
        local missing = {}
        if not has_cc then
          missing[#missing + 1] = 'C 编译器 (gcc/clang/zig)'
        end
        if not has_ts_cli then
          missing[#missing + 1] = 'tree-sitter-cli'
        end
        vim.schedule(function()
          vim.notify(
            'Treesitter 降级：缺少 ' .. table.concat(missing, '、')
              .. '，仅使用 Neovim 内置 parser。装齐后重启自动启用。',
            vim.log.levels.WARN
          )
        end)
      end

      require('nvim-treesitter').setup {
        install_dir = vim.fn.stdpath('data') .. '/site',
      }

      -- 有 cli + 编译器才安装 parser（异步，不阻塞启动）
      if can_install then
        require('nvim-treesitter').install(languages)
      end

      -- 高亮（Neovim 内置；parser 缺失时静默）
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      -- 缩进（实验性，保持旧配置行为）
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- Windows 兜底：若编译产物是 .so 则复制为 .dll（找不到 .so 时无副作用）
      if vim.fn.has('win32') == 1 then
        local function fix_parser_dlls()
          local dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'site', 'parser')
          if vim.fn.isdirectory(dir) == 1 then
            for _, so in ipairs(vim.fn.glob(vim.fs.joinpath(dir, '*.so'), false, true)) do
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
