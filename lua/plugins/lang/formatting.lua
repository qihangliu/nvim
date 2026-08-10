-- ============================================================
-- 格式化 (conform)（自动检测）
-- 核心：Python(ruff) / Lua(stylua) / Bash(shfmt)
-- 可选：JS-TS/JSON/YAML/Markdown/HTML/CSS(prettierd 或 prettier)
-- 工具安装示例：
--   Python: uv tool install ruff
--   Lua:    cargo install stylua
--   Bash:   shfmt（下载二进制或包管理器）
--   JS-TS/JSON/YAML 等: npm i -g prettierd（或 prettier）
-- ============================================================
local function has_any_formatter()
  local bins = { 'ruff', 'stylua', 'shfmt', 'prettierd', 'prettier' }
  for _, bin in ipairs(bins) do
    if vim.fn.executable(bin) == 1 then
      return true
    end
  end
  return false
end

-- prettierd 优先（更快），其次 prettier
local function prettier_formatter()
  if vim.fn.executable('prettierd') == 1 then
    return 'prettierd'
  end
  if vim.fn.executable('prettier') == 1 then
    return 'prettier'
  end
  return nil
end

return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    enabled = has_any_formatter(),
    config = function()
      -- 动态构建 formatters_by_ft，只包含已安装的工具
      local formatters_by_ft = {}
      if vim.fn.executable('ruff') == 1 then
        formatters_by_ft.python = { 'ruff_format' }
      end
      if vim.fn.executable('stylua') == 1 then
        formatters_by_ft.lua = { 'stylua' }
      end
      if vim.fn.executable('shfmt') == 1 then
        formatters_by_ft.bash = { 'shfmt' }
        formatters_by_ft.sh = { 'shfmt' }
      end
      local prettier = prettier_formatter()
      if prettier then
        for _, ft in ipairs({ 'javascript', 'typescript', 'json', 'yaml', 'markdown', 'html', 'css' }) do
          formatters_by_ft[ft] = { prettier }
        end
      end
      require('conform').setup({
        formatters_by_ft = formatters_by_ft,
        format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
      })
    end,
  },
}