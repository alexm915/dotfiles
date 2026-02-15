--拼接出plugin manager(lazy-vim)的安装路径
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--如果不存在lazy-vim,则下载最新稳定版放到lazypath
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
--将lazypath链接到neovim
vim.opt.rtp:prepend(lazypath)

--让lazy-vim到"plugin" directory中找各个plugin config
require("lazy").setup("plugins",{
    install = {missing=true},
    checker = {enabled=true},
})
