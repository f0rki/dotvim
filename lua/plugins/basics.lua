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

    -- Autocompletion
    -- check out sources: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
    { "hrsh7th/cmp-buffer" },
    -- {'hrsh7th/cmp-path'},
    { "FelipeLema/cmp-async-path" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "lukas-reineke/cmp-rg" },
    { "hrsh7th/cmp-nvim-lsp-signature-help" },
    { "hrsh7th/cmp-nvim-lua" },
    -- {'tzachar/cmp-ai'},

    { "hrsh7th/nvim-cmp" },

    -- snippets
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
    { "rafamadriz/friendly-snippets" },

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

    -- rust
    { "rust-lang/rust.vim" },
    { "cespare/vim-toml" },
    { "simrat39/rust-tools.nvim" },
    { "saecki/crates.nvim" },

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
