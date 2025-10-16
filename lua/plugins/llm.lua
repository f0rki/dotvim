return {
	{
		"olimorris/codecompanion.nvim",
		opts = {
			strategies = {
				chat = { adapter = "ollama_chat" },
				inline = { adapter = "ollama_inline" },
			},

			adapters = {
				http = {
					ollama_inline = function()
						return require("codecompanion.adapters").extend("ollama", {
							schema = {
								model = {
									default = "qwen2.5-coder:0.5b",
								},
							},
						})
					end,

					ollama_chat = function()
						return require("codecompanion.adapters").extend("ollama", {
							schema = {
								model = {
									default = "qwen2.5-coder:3b",
								},
							},
						})
					end,
				},
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	-- { "azorng/goose.nvim" },
}
