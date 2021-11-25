require("lualine").setup({
	options = {
		--theme = "material-nvim",
		--theme = "github",
		theme = "onedark",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { "filename" },
		lualine_x = { { "diagnostics", sources = { "ale" } } },
		lualine_y = { "encoding", "fileformat", "filetype" },
		lualine_z = { "location" },
	},
	extensions = { "fzf", "fugitive" },
})

require("Comment").setup()

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
