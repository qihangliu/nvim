-- ============================================================
-- LSP 支持（自动检测）
-- 检测系统已安装的 LSP 服务器，有则启用、无则跳过
-- 核心：Python(basedpyright) / Lua(lua-language-server) / Bash(bash-language-server)
-- 可选：JS-TS(typescript-language-server) / JSON(jsonls) / YAML(yamlls)
-- 工具安装示例：
--   Python: uv tool install basedpyright
--   Lua:    lua-language-server（下载二进制或包管理器）
--   Bash:   npm i -g bash-language-server
--   JS-TS:  npm i -g typescript-language-server
--   JSON:   npm i -g vscode-langservers-extracted
--   YAML:   npm i -g yaml-language-server
-- ============================================================
local function has_any_server()
  local bins = {
    'basedpyright', 'lua-language-server', 'bash-language-server',
    'typescript-language-server', 'json-languageserver', 'yaml-language-server',
  }
  for _, bin in ipairs(bins) do
    if vim.fn.executable(bin) == 1 then
      return true
    end
  end
  return false
end

return {
  -- LSP 配置
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    enabled = has_any_server(),
    config = function()
      -- 服务器名 → 可执行文件名映射
      local servers = {
        { name = 'basedpyright', bin = 'basedpyright' },
        { name = 'lua_ls',       bin = 'lua-language-server' },
        { name = 'bashls',       bin = 'bash-language-server' },
        { name = 'ts_ls',        bin = 'typescript-language-server' },
        { name = 'jsonls',       bin = 'json-languageserver' },
        { name = 'yamlls',       bin = 'yaml-language-server' },
      }
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      for _, s in ipairs(servers) do
        if vim.fn.executable(s.bin) == 1 then
          vim.lsp.config(s.name, { capabilities = capabilities })
          vim.lsp.enable(s.name)
        end
      end

      -- LSP 快捷键
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }
      map('n', 'gd', vim.lsp.buf.definition, opts)
      map('n', 'K', vim.lsp.buf.hover, opts)
      map('n', 'gi', vim.lsp.buf.implementation, opts)
      map('n', 'gr', vim.lsp.buf.references, opts)
      map('n', '<leader>rn', vim.lsp.buf.rename, opts)
      map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      map('n', '<leader>d', vim.diagnostic.open_float, opts)
      map('n', '[d', vim.diagnostic.goto_prev, opts)
      map('n', ']d', vim.diagnostic.goto_next, opts)
    end,
  },
}