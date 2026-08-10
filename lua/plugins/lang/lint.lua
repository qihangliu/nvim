-- ============================================================
-- Lint (nvim-lint)（自动检测）
-- 核心：Python(ruff) / Lua(luacheck) / Bash(shellcheck)
-- 可选：JS-TS(eslint) / YAML(yamllint)
-- 工具安装示例：
--   Python: uv tool install ruff
--   Lua:    luacheck（luarocks 或包管理器）
--   Bash:   shellcheck（apt/brew 等）
--   JS-TS:  npm i -g eslint
--   YAML:   yamllint（pip 或包管理器）
-- ============================================================
local function has_any_linter()
  local bins = { 'ruff', 'luacheck', 'shellcheck', 'eslint', 'yamllint' }
  for _, bin in ipairs(bins) do
    if vim.fn.executable(bin) == 1 then
      return true
    end
  end
  return false
end

return {
  {
    'mfussenegger/nvim-lint',
    event = 'BufWritePost',
    enabled = has_any_linter(),
    config = function()
      -- 动态构建 linters_by_ft，只包含已安装的工具
      local linters_by_ft = {}
      if vim.fn.executable('ruff') == 1 then
        linters_by_ft.python = { 'ruff' }
      end
      if vim.fn.executable('luacheck') == 1 then
        linters_by_ft.lua = { 'luacheck' }
      end
      if vim.fn.executable('shellcheck') == 1 then
        linters_by_ft.bash = { 'shellcheck' }
        linters_by_ft.sh = { 'shellcheck' }
      end
      if vim.fn.executable('eslint') == 1 then
        linters_by_ft.javascript = { 'eslint' }
        linters_by_ft.typescript = { 'eslint' }
      end
      if vim.fn.executable('yamllint') == 1 then
        linters_by_ft.yaml = { 'yamllint' }
      end
      require('lint').linters_by_ft = linters_by_ft
    end,
  },
}