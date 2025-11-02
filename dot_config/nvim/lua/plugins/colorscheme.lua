return{
  { 
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            transparent_background = false,
            intergrations = {
                treesitter = true,
                nvimtree =true,
                lualine = true,
                cmp = true,
            },
        })
      vim.cmd.colorscheme("catppuccin")
    end,
  }
}
