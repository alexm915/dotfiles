--设置 leader 键为空格,leader键即normal下使用/,类似win键。
vim.g.mapleader = " "


-- ==================== Auto-install lazy.nvim ====================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", { install = { missing = true } })



-- ==================== Editor behavior and keymapping ====================


--缩进
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4 --backspace当成4个空格删除
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.list = true  --显示不可见字符
vim.opt.listchars = { tab = "▸ ", trail = "▫" }
vim.opt.scrolloff = 5 --光标上下边界至少保留5行
vim.opt.backspace = { "indent", "eol", "start" } --允许backspace删除缩进，换行符和插入前的内容
vim.opt.foldmethod = "indent" --根据缩进折叠代码
vim.opt.foldlevel = 99 --默认打开所有折叠
vim.opt.autochdir = true --自动切换工作目录为当前文件目录


--搜索
vim.opt.hlsearch = true
vim.cmd("nohlsearch")   -- 新文件取消上次搜索的高亮结果
vim.opt.incsearch =true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.showcmd = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wildmenu = true --按tab出现可选菜单
vim.opt.wrap=true --自动换行
vim.opt.termguicolors = true


--键位Shorcuts
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })
vim.keymap.set('n', 'K', '5k', { noremap = true, silent = true })
vim.keymap.set('n', 'J', '5j', { noremap = true, silent = true })
vim.keymap.set('n', 'Q', ':q<CR>', { noremap = true, silent = true, desc="用Q来退出"})
vim.keymap.set('n', '=', 'nzz', { noremap = true, silent = true, desc="=搜索结果上翻并居中"})
vim.keymap.set('n', '-', 'Nzz', { noremap = true, silent = true })
vim.keymap.set('n', 'S', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'R', ':Lazy sync<CR>', { noremap = true, silent = true, desc="R更新neovim配置"})
vim.keymap.set("n", "<leader><CR>", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "space+enter取消搜索高亮" })

vim.keymap.set('n', 'sr', ':set splitright<CR>:vsplit<CR>', { noremap = true, silent = true , desc = "右分屏"})
vim.keymap.set('n', 'sl', ':set nosplitright<CR>:vsplit<CR>', { noremap = true, silent = true , desc = "左分屏"})
vim.keymap.set('n', 'su', ':set nosplitbelow<CR>:split<CR>', { noremap = true, silent = true , desc = "上分屏"})
vim.keymap.set('n', 'sb', ':set splitbelow<CR>:split<CR>', { noremap = true, silent = true , desc = "上分屏"})
vim.keymap.set('n', '<LEADER>h', '<C-w>h', {noremap = true, silent = true, desc = '分屏光标向右屏移动'})
vim.keymap.set('n', '<LEADER>l', '<C-w>l', {noremap = true, silent = true, desc = '向左边移动'})
vim.keymap.set('n', '<LEADER>k', '<C-w>k', {noremap = true, silent = true, desc = '光标向上屏'})
vim.keymap.set('n', '<LEADER>j', '<C-w>j ', {noremap = true, silent = true, desc = '光标向下屏'})
vim.keymap.set('n', '<up>', ':res +5<CR>', {noremap = true, silent =true, desc='用方向键resize分屏'})
vim.keymap.set('n', '<down>', ':res -5<CR>', {noremap = true, silent =true, desc='用方向键resize分屏'})
vim.keymap.set('n', '<left>', ':vertical resize-5<CR>', {noremap = true, silent =true, desc='用方向键resize分屏'})
vim.keymap.set('n', '<right>', ':vertical resize+5<CR>', {noremap = true, silent =true, desc='用方向键resize分屏'})
vim.keymap.set('n', 'sv', '<C-w>t<C-w>H', {noremap = true, silent =true, desc='上下、左右分屏互换'})
vim.keymap.set('n', 'sh', '<C-w>t<C-w>K', {noremap = true, silent =true, desc='上下、左右分屏互换'})

vim.keymap.set('n', 'tn', ':tabe<CR>', {noremap = true, silent =true, desc='打开新标签页'})
vim.keymap.set('n', 'th', ':-tabnext<CR>', {noremap = true, silent =true, desc='跳到左边的标签页'})
vim.keymap.set('n', 'tl', ':+tabnext<CR>', {noremap = true, silent =true, desc='跳到右边的标签页'})

vim.keymap.set('n', '<LEADER>sc', ':set spell!<CR>', {noremap = true, silent =true, desc='spell check'})


--load plugins
require("config.lazy")
