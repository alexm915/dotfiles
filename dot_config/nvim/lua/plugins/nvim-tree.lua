--文件浏览树
return {
    { "nvim-neo-tree/neo-tree.nvim", enabled = false },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- 可选，添加图标支持
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            require("nvim-tree").setup({
                sort = {
                    sorter = "case_sensitive", -- 区分大小写排序
                },
                view = {
                    width = 30, -- 侧边栏宽度
                    side = "left", -- 侧边栏位置（默认左边，可设为 "right"）
                },
                renderer = {
                    group_empty = true, -- 合并空目录
                    icons = {
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                            git = true,
                        },
                    },
                },
               filters = {
                   dotfiles = false, -- 默认显示点文件（可按 H 切换）
               },
               git = {
                   enable = true, -- 启用 Git 状态显示
                   ignore = false, -- 显示 Git 忽略的文件
               },
           })
       end,
       keys = {
           { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
           { "<leader>E", "<cmd>NvimTreeFindFile<cr>", desc = "Find File in NvimTree" },
       },
   },
}
