require("lualine").setup({
	options = {
		theme = "material-nvim",
		--theme = "github",
		-- theme = "onedark",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { "filename" },
		lualine_x = { { "diagnostics", sources = { "nvim_lsp", "nvim_diagnostic", "ale" } } },
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

-- setup LSP config
require("grammar-guard").init()

require("lspconfig").grammar_guard.setup({
	cmd = { "ltex-ls" },
	settings = {
		ltex = {
			enabled = { "latex", "tex", "bib", "markdown", "bibtex" },
			language = "en-US",
			diagnosticSeverity = "information",
			setenceCacheSize = 2000,
			additionalRules = {
				enablePickyRules = true,
				motherTongue = "de-DE",
				word2VecModel = "~/.lt_data/word2vec/",
				languageModel = "~/.lt_data/ngram/",
			},
			trace = { server = "verbose" },
			dictionary = {},
			disabledRules = {},
			hiddenFalsePositives = {},
		},
	},
})

require("lspconfig").rust_analyzer.setup({})

require("lspconfig").clangd.setup({})
