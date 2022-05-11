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

-------
-- http://lua-users.org/wiki/FileInputOutput
-- see if the file exists
function file_exists(file)
	local f = io.open(file, "rb")
	if f then
		f:close()
	end
	return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
function lines_from(file)
	if not file_exists(file) then
		return {}
	end
	local lines = {}
	for line in io.lines(file) do
		lines[#lines + 1] = string.gsub(line, "%s+", "")
	end
	return lines
end
-------

require("lspconfig").grammar_guard.setup({
	cmd = { "ltex-ls" },
	settings = {
		ltex = {
			enabled = { "latex", "tex", "bib", "markdown", "bibtex" },
			language = "en-US",
			diagnosticSeverity = "information",
			sentenceCacheSize = 2000,
			additionalRules = {
				enablePickyRules = true,
				motherTongue = "de-DE",
				languageModel = "~/.lt_data/ngram/",
				word2VecModel = "~/.lt_data/word2vec/",
			},
			trace = { server = "verbose" },
			dictionary = {
				["en-US"] = {
					table.unpack(lines_from("./.dict.txt")),
					table.unpack(lines_from("~/.config/ltex/dict-en.txt")),
				},
				-- ["de-DE"] = lines_from("./.dict.txt") + lines_from("~/.config/ltex/dict-de.txt"),
			},
			disabledRules = {},
			hiddenFalsePositives = {},
		},
	},
})

require("lspconfig").rust_analyzer.setup({})

require("lspconfig").clangd.setup({})

require("lspconfig").pylsp.setup({})

require("lspconfig").gopls.setup({})

require("trouble").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
})

require("rust-tools").setup({})
