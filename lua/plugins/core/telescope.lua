-- ============================================================
-- Telescope 模糊查找
-- ============================================================
return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    cmd = 'Telescope',
    config = function()
      require('telescope').setup({
        defaults = {
          sorting_strategy = 'ascending',
          layout_config = { prompt_position = 'top' },
        },
      })
      local builtin = require('telescope.builtin')
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }
      map('n', '<leader>ff', builtin.find_files, opts)
      map('n', '<leader>fg', builtin.live_grep, opts)
      map('n', '<leader>fb', builtin.buffers, opts)
      map('n', '<leader>fh', builtin.help_tags, opts)
      map('n', '<leader>fs', builtin.lsp_document_symbols, opts)
    end,
  },
}
