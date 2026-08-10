-- ============================================================
-- 基础选项（由原 init.vim 翻译而来）
-- ============================================================
local opt = vim.opt

-- 通用
opt.compatible = false          -- 不兼容原始 vi 模式
vim.cmd('filetype plugin on')   -- 文件类型侦测 + 插件
vim.cmd('syntax on')            -- 语法高亮
opt.errorbells = false          -- 关闭错误提示音
opt.termguicolors = true        -- 真彩色（Windows Terminal 支持）
opt.cmdheight = 1               -- 命令行高度
opt.showcmd = true              -- 显示选中的行数
opt.ruler = true                -- 显示光标位置
opt.laststatus = 2              -- 始终显示状态栏
opt.number = true               -- 行号
opt.cursorline = true           -- 高亮当前行
opt.whichwrap = opt.whichwrap + '<,>,h,l'  -- 光标键跨行
opt.ttimeoutlen = 0             -- ESC 键响应时间
opt.virtualedit = 'block,onemore' -- 允许光标在最后一个字符后
opt.history = 100               -- 历史记录条数

-- 缩进与排版
opt.autoindent = true
opt.cindent = true
opt.cinoptions = 'g0,:0,N-s,(0'
opt.smartindent = true
vim.cmd('filetype indent on')
opt.expandtab = true            -- 空格代替 Tab
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smarttab = true
opt.wrap = false                -- 禁止折行
opt.backspace = 'indent,eol,start'
opt.sidescroll = 10
opt.foldenable = false          -- 禁用折叠

-- 补全
opt.wildmenu = true             -- 命令行智能补全
opt.completeopt = { 'menu', 'menuone', 'noselect' } -- 补全不弹预览窗口

-- 搜索
opt.hlsearch = true             -- 高亮搜索结果
opt.incsearch = true            -- 实时搜索
opt.ignorecase = false          -- 大小写敏感

-- 缓存
opt.backup = false              -- 不备份
opt.swapfile = false            -- 不生成 swap
opt.undofile = true             -- 持久化撤销历史（跨会话保留）
opt.autoread = true             -- 外部修改自动重读
opt.autowrite = true            -- 自动保存
opt.confirm = true              -- 未保存时弹出确认

-- 编码（Neovim 已内置 UTF-8，无需 termencoding）
opt.fileencodings = 'utf8,ucs-bom,gbk,cp936,gb2312,gb18030'

-- 现代配置补充
opt.signcolumn = 'yes'          -- 始终显示符号列（LSP 诊断图标）
opt.updatetime = 250           -- 更新延迟（gitsigns 等需要）
opt.clipboard = 'unnamedplus'  -- 与系统剪贴板共享
opt.mouse = 'a'                -- 启用鼠标
opt.scrolloff = 8              -- 光标上下留白
opt.sidescrolloff = 8
opt.splitright = true          -- 新分屏在右侧
opt.splitbelow = true          -- 新分屏在下方
opt.termguicolors = true
