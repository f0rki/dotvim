require("lualine").setup({
	options = {
		-- theme = "material-nvim",
		--theme = "github",
		theme = "onedark",
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

require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})
require("telescope").load_extension("ui-select")

local telescope_builtin = require("telescope.builtin")
-- respects .gitignore
vim.keymap.set("n", "<leader>f", telescope_builtin.find_files, { desc = "Telescope find files (respects .gitignore)" })
vim.keymap.set("n", "<leader>g", telescope_builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>b", telescope_builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>q", telescope_builtin.grep_string, { desc = "Telescope grep string" })
-- vim.keymap.set('n', '<leader>h', telescope_builtin.help_tags, { desc = 'Telescope help tags' })

-- treesitter stuff
-- require('nvim-treesitter.install'.compilers = { 'gcc' }
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
		-- vimtex recommends disabling tree-sitter for latex
		-- disable = { "latex" },
		disable = { "latex", "Makefile" },
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
local luasnip = require("luasnip")

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

local lspconfig = require("lspconfig")

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- lsp-zero is deprecated... move to plain lsp-config
-- local lspzero = require("lsp-zero").preset()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- lspzero.default_keymaps({ buffer = bufnr })

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	-- vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<localleader>i", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
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
	vim.keymap.set("n", "<F3>", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)

	-- TODO: wut are these?
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
end

local lsp_cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- initialize the lsps
local lsps = { "rust_analyzer", "clangd", "pyright", "gopls", "ruff", "dprint", "lua_ls" }
for _, lsp in pairs(lsps) do
	local setup = {
		on_attach = on_attach,
		capabilities = lsp_cmp_capabilities,
	}
	lspconfig[lsp].setup(setup)
end

-- see also https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/guides/integrate-with-null-ls.md
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		-- null_ls.builtins.code_actions.shellcheck,
		null_ls.builtins.code_actions.statix,
		null_ls.builtins.diagnostics.fish,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.clang_format,
		-- null_ls.builtins.formatting.nixpkgs_fmt,
		null_ls.builtins.formatting.alejandra,
		null_ls.builtins.formatting.bibclean,
		-- null_ls.builtins.formatting.dprint,

		null_ls.builtins.diagnostics.todo_comments,

		-- python
		-- null_ls.builtins.diagnostics.ruff,
		null_ls.builtins.diagnostics.pylint,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.black,
	},
})

-- pretty list of LSP reported issues
require("trouble").setup({})

-- we want a bunch of nice rusty features :)
require("rust-tools").setup({})
require("crates").setup({
	null_ls = {
		enabled = true,
		name = "crates.nvim",
	},
})

-- setup auto complete
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Set up nvim-cmp.
local cmp = require("cmp")
-- local cmp_action = lspzero.cmp_action()

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-Tab>"] = cmp.mapping.complete(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_locally_jumpable()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "crates" },
	}, {
		{ name = "buffer" },
		{ name = "async_path" },
		{ name = "rg", keyword_length = 4, option = { additional_arguments = "--smart-case" } },
		-- { name = 'emoji' },
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
