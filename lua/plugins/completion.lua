-- Autocompletion
-- check out sources: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
-- local sources = {
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-path",
--     "hrsh7th/cmp-cmdline",
--     "hrsh7th/cmp-nvim-lsp",
--     "lukas-reineke/cmp-rg",
--     "hrsh7th/cmp-nvim-lsp-signature-help",
--     "hrsh7th/cmp-nvim-lua",
--     "hrsh7th/nvim-cmp",
--     "hrsh7th/cmp-emoji"
-- }
-- local plugins = {
--     {
--         "hrsh7th/nvim-cmp",
--         version = false,
--         event = "InsertEnter",
--         dependencies = sources,
--     },
-- }
--
-- return plugins

function has_words_before()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
    -- snippets
    { "L3MON4D3/LuaSnip" },
    { "rafamadriz/friendly-snippets" },
    -- completion
    {
        "saghen/blink.cmp",
        lazy = false,
        dependencies = {
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            -- additonal sources
            "moyiz/blink-emoji.nvim",
        },

        -- use a release tag to download pre-built binaries
        version = "1.*",
        -- build = 'nix run .#build-plugin',

        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = {
                preset = "enter",

                -- old mappings from using cmp
                -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
                -- ["<C-e>"] = cmp.mapping.abort(),
                -- ["<CR>"] = cmp.mapping.confirm({ select = false }),
                -- ["<C-Tab>"] = cmp.mapping.complete(),
                -- ["<Tab>"] = cmp.mapping(function(fallback)
                --     if cmp.visible() then
                --         cmp.select_next_item()
                --     elseif luasnip.expand_or_jumpable() then
                --         luasnip.expand_or_locally_jumpable()
                --     elseif has_words_before() then
                --         cmp.complete()
                --     else
                --         fallback()
                --     end
                -- end, { "i", "s" }),
                -- ["<S-Tab>"] = function(cmp) cmp.mapping(function(fallback)
                --     if cmp.visible() then
                --         cmp.select_prev_item()
                --     elseif luasnip.jumpable(-1) then
                --         luasnip.jump(-1)
                --     else
                --         fallback()
                --     end
                -- end, { "i", "s" }),

                -- 
                -- ["<A-y>"] = {
                --     function(cmp)
                --         require("minuet").make_blink_map()
                --     end,
                -- },
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { "lsp", "path", "snippets", "buffer", "emoji" },

                providers = {
                    -- minuet = {
                    --     name = "minuet",
                    --     module = "minuet.blink",
                    --     async = true,
                    --     -- Should match minuet.config.request_timeout * 1000,
                    --     -- since minuet.config.request_timeout is in seconds
                    --     timeout_ms = 3000,
                    --     score_offset = 50, -- Gives minuet higher priority among suggestions
                    -- },
                    emoji = {
                        module = "blink-emoji",
                        name = "Emoji",
                        score_offset = 15, -- Tune by preference
                        opts = {
                            insert = true, -- Insert emoji (default) or complete its name
                            ---@type string|table|fun():table
                            trigger = function()
                                return { ":" }
                            end,
                        },
                        should_show_items = function()
                            return vim.tbl_contains(
                            -- Enable emoji completion only for git commits and markdown.
                            -- By default, enabled for all file-types.
                                { "gitcommit", "markdown" },
                                vim.o.filetype
                            )
                        end,
                    },
                },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
}
