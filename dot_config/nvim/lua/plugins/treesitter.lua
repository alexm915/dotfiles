--语法高亮
return{
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'cpp', 'lua', 'python' },
        highlight = { enable = true }
      })
    end,
  }
}
