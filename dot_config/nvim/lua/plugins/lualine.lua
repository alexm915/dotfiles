--status bar
return{
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = "VeryLazy",
        config = function()
            local function time()
                return os.date("%H:%M:%S")
            end

            require("lualine").setup({
                options ={
                    icons_enabled =true,
                    theme ="catppuccin",
                    componet_separators ={ left ="|", right="|"},
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = { statusline = { "dashboard", "alpha" } },
                    always_divide_middle = true,
                    globalstatus = true,
                },
                sections ={
                    lualine_a ={"mode"},
                    lualine_b ={"branch", "diff", "diagnostics"},
                    lualine_c ={"filename"},
                    lualine_x ={"encoding", "fileformat", "filetype"},
                    lualine_y ={"progress"},
                    lualine_z ={"location", time},
                },
                inactive_sections ={
                    lualine_a ={},
                    lualine_b ={},
                    lualine_c ={"filename"},
                    lualine_x ={"location"},
                    lualine_y ={},
                    lualine_z ={},
                },
                tabline ={},
                winbar ={},
                inactive_winbar ={},
                extensions ={ "nvim-tree"},
            })
        end,
    },
}
