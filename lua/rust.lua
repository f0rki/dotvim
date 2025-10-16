-- we want a bunch of nice rusty features :)
-- TODO: 
require("rust-tools").setup({})
require("crates").setup({
	null_ls = {
		enabled = true,
		name = "crates.nvim",
	},
})
