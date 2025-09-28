-- 自动补全
return{
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp", -- LSP 补全源
        "hrsh7th/cmp-buffer", -- 缓冲区补全源
        "hrsh7th/cmp-path", -- 路径补全源
        "L3MON4D3/LuaSnip", -- 片段引擎
        "saadparwaiz1/cmp_luasnip", -- LuaSnip 补全源
        "hrsh7th/cmp-cmdline", -- 命令行补全源
    },
    event = { "InsertEnter", "CmdlineEnter" }, -- 触发补全的时机
    config = function()
        local cmp =require("cmp")
        local luasnip =require("luasnip")

        cmp.setup({
            snippet ={
                expand =function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            sources =cmp.config.sources({
                { name = "nvim_lsp", max_item_count = 15 }, -- LSP 补全
                { name = "luasnip", max_item_count = 10 }, -- 代码片段
                { name = "buffer", max_item_count = 10 }, -- 缓冲区
                { name = "path", max_item_count = 5 }, -- 路径
            }),
            mapping =cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(), -- 下一个补全项
                ["<C-p>"] = cmp.mapping.select_prev_item(), -- 上一个补全项
                ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- 向上滚动文档
                ["<C-f>"] = cmp.mapping.scroll_docs(4), -- 向下滚动文档
                ["<C-Space>"] = cmp.mapping.complete(), -- 手动触发补全
                ["<C-e>"] = cmp.mapping.abort(), -- 取消补全
                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- 确认补全
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),

            formatting ={
                format =function(entry, vim_item)
                    local kind_icons ={
                        Text = "󰉿",
                        Method = "󰆧",
                        Function = "󰊕",
                        Constructor = "",
                        Field = "󰜢",
                        Variable = "󰀫",
                        Class = "󰌷",
                        Interface = "󰅺",
                        Module = "󰏪",
                        Property = "󰜢",
                        Unit = "󰑭",
                        Value = "󰎠",
                        Enum = "󰕘",
                        Keyword = "󰌋",
                        Snippet = "󰅱",
                        Color = "󰏘",
                        File = "󰈙",
                        Reference = "󰈇",
                        Folder = "󰉋",
                        EnumMember = "󰕘",
                        Constant = "󰏿",
                        Struct = "󰌵",
                        Event = "󰬬",
                        Operator = "󰆕",
                        TypeParameter = "󰊄",
                    }
                    vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
                    vim_item.menu=({
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snippet]",
                        buffer = "[Buffer]",
                        path = "[Path]",
                    })[entry.source.name]
                    return vim_item
                end,
            },
            experimental ={
                ghost_text =true,
            },
            window={
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        })

        --命令行补全
        cmp.setup.cmdline(":",{
            mapping =cmp.mapping.preset.cmdline({
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),

            sources =cmp.config.sources({
                {name="path"},
                {name="cmdline"},
            }),
        })

        --搜索补全
        cmp.setup.cmdline("/",{
            mapping =cmp.mapping.preset.cmdline(),
            sources ={
                {name="buffer"},
            },
        })
    end,
  },
}
