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

-- treesitter stuff
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
		-- vimtex recommends disabling tree-sitter for latex
		disable = { "latex" },
        -- make sure a bunch of useful ones are installed all the time
        ensure_installed = {
            'lua',
            'rust',
            'c',
            'cpp',
            'bash',
            'markdown',
            'make',
            'python'
        }
	},
})

-- auto-install TS parsers on first open of unknown
local ask_install = {}
function _G.ensure_treesitter_language_installed()
  local parsers = require "nvim-treesitter.parsers"
  local lang = parsers.get_buf_lang()
  if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) and ask_install[lang] ~= false then
    vim.schedule_wrap(function()
      vim.ui.select({"yes", "no"}, { prompt = "Install tree-sitter parsers for " .. lang .. "?" }, function(item)
        if item == "yes" or item == "y" then
          vim.cmd("TSInstall " .. lang)
        elseif item == "no" then
          ask_install[lang] = false
        end
      end)
    end)()
  end
end
vim.cmd [[autocmd FileType * :lua ensure_treesitter_language_installed()]]
----------

-- highlight function args using treesitter
require("hlargs").setup()

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
--[[

require("grammar-guard").init()
require("lspconfig").grammar_guard.setup({
	cmd = { "ltex-ls" },
	settings = {
		ltex = {
			enabled = { "latex", "tex", "bib", "markdown", "bibtex", "rst", "reStructuredText" },
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
					--table.unpack(lines_from("./.dict.txt")),
					--table.unpack(lines_from("~/.config/ltex/dict-en.txt")),
				},
				-- ["de-DE"] = lines_from("./.dict.txt") + lines_from("~/.config/ltex/dict-de.txt"),
			},
			disabledRules = {},
			hiddenFalsePositives = {},
		},
	},
})
--]]

-- initialize the lsps
require("lspconfig").rust_analyzer.setup({})
require("lspconfig").clangd.setup({})
require("lspconfig").pylsp.setup({})
require("lspconfig").gopls.setup({})
-- we want a bunch of nice rusty features :)
require("rust-tools").setup({})

-- pretty list of LSP reported issues
require("trouble").setup({})
