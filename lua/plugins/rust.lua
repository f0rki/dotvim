return {
    -- { "rust-lang/rust.vim" },
    -- { "simrat39/rust-tools.nvim" },
    {
        "mrcjkb/rustaceanvim",
        version = "^6", -- Recommended
        lazy = false, -- This plugin is already lazy
    },
    {
        "saecki/crates.nvim",
        tag = "stable",
        event = { "BufRead Cargo.toml" },
        config = function()
            require("crates").setup()
        end,
    },
}
