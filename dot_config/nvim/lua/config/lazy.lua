-- to make plugin manager lazy.nvim installation path
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- if lazy.nvim not exist, install the stable verion into path
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end

-- link lazypath to neovim runtimepath
vim.opt.rtp:prepend(lazypath)

-- tell nvim to find plugins config
require("lazy").setup("plugins",{
    install = {missing=true},
    checker = {enabled=true},

    rocks = {
        enabled = false,
    },
})
