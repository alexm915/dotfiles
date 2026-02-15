--Language-Highlight
return{
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'cpp', 'rust','python','lua', 'python','toml' },
        highlight = { enable = true }
      })
    end,
  }
}
