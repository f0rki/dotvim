return {
    -- color schemes
    { "marko-cerovac/material.nvim",                lazy = false },
    { "rebelot/kanagawa.nvim",                      lazy = false },

    { "tpope/vim-sensible",                         lazy = false },
    { "nvim-lua/plenary.nvim",                      lazy = false },
    { "nvim-tree/nvim-web-devicons",                lazy = false },
    { "nvim-lualine/lualine.nvim",                  lazy = false },
    { "ggandor/lightspeed.nvim",                    lazy = false },
    { "lewis6991/gitsigns.nvim" },
    { "tpope/vim-fugitive" },
    { "nvim-telescope/telescope.nvim",              branch = "0.1.x",   dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "folke/todo-comments.nvim" },

    { "nvim-treesitter/nvim-treesitter",            build = ":TSUpdate" },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "m-demare/hlargs.nvim" },

    { "rickhowe/diffchar.vim" },

    { "machakann/vim-highlightedyank" },
    { "godlygeek/tabular" },

    -- checker for writing style
    { "reedes/vim-wordy" },

    { "neovim/nvim-lspconfig",                      lazy = false },



    -- formatting tools as lsp
    { "nvimtools/none-ls.nvim" },
    -- TODO: better formatting? alternative to none-ls
    -- {'stevearc/conform.nvim'},

    -- view diagnostics
    { "folke/trouble.nvim" },

    { "numToStr/Comment.nvim" },

    -- latex
    { "lervag/vimtex" },
    -- TODO: checkout the texlab lsp implementation; seems to require tectonic though
    -- https://github.com/latex-lsp/texlab

    -- other formats/languages
    { "dag/vim-fish" },
    -- { "plasticboy/vim-markdown" },
    -- { "ethereum/vim-solidity" },
    --{'derekwyatt/vim-scala'},
    --{'kchmck/vim-coffee-script'},
    --{'vim-scripts/yaml.vim'},
    -- { "freitass/todo.txt-vim" },
    { "LnL7/vim-nix" },

    -- {
    -- 	"OXY2DEV/markview.nvim",
    -- 	lazy = false,
    --
    -- 	-- For `nvim-treesitter` users.
    -- 	priority = 49,
    --
    -- 	-- For blink.cmp's completion
    -- 	-- source
    -- 	-- dependencies = {
    -- 	--     "saghen/blink.cmp"
    -- 	-- },
    -- },
    --

    { "sindrets/diffview.nvim" },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons", -- optional, but recommended
        },
        lazy = false,                -- neo-tree will lazily load itself
    }
}
