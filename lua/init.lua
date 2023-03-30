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
			"lua",
			"rust",
			"c",
			"cpp",
			"bash",
			"markdown",
			"make",
			"python",
		},
	},
})

-- auto-install TS parsers on first open of unknown
local ask_install = {}
function _G.ensure_treesitter_language_installed()
	local parsers = require("nvim-treesitter.parsers")
	local lang = parsers.get_buf_lang()
	if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) and ask_install[lang] ~= false then
		vim.schedule_wrap(function()
			vim.ui.select(
				{ "yes", "no" },
				{ prompt = "Install tree-sitter parsers for " .. lang .. "?" },
				function(item)
					if item == "yes" or item == "y" then
						vim.cmd("TSInstall " .. lang)
					elseif item == "no" then
						ask_install[lang] = false
					end
				end
			)
		end)()
	end
end
vim.cmd([[autocmd FileType * :lua ensure_treesitter_language_installed()]])
----------

-- highlight function args using treesitter
require("hlargs").setup()

-- setup vscode style snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Set up nvim-cmp.
local cmp = require("cmp")

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		-- { name = "vsnip" }, -- For vsnip users.
		{ name = "luasnip" }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = "buffer" },
	}),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

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

------ lsp keybindings
-- https://github.com/neovim/nvim-lspconfig#Suggested-configuration

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

local lspzero = require("lsp-zero").preset(lsp_std_config)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	lspzero.default_keymaps({ buffer = bufnr })

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	-- vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<localleader>i", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<localleader>x", vim.lsp.buf.references, bufopts)

	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)

	vim.keymap.set("n", "<localleader>td", vim.lsp.buf.type_definition, bufopts)

	vim.keymap.set("n", "<localleader>r", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<localleader>c", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)

	vim.keymap.set("n", "<localleader>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)

	-- TODO: wut are these?
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

local lsp_cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp_std_config = {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = lsp_cmp_capabilities,
}

-- initialize the lsps
local LSPs = { "rust_analyzer", "clangd", "pylsp", "gopls" }
lspzero.on_attach(on_attach)
lspzero.setup_servers(LSPs)
lspzero.setup()

-- we want a bunch of nice rusty features :)
require("rust-tools").setup({})

-- pretty list of LSP reported issues
require("trouble").setup({})
