require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		disable = { "yaml" },
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "si",
			node_incremental = "si",
			scope_incremental = "ss",
			node_decremental = "sd",
		},
	},
	indent = {
		enable = true,
		--disable = { "python" } -- exclude language if you encounter problems
	},
})

require("tree-sitter-just").setup({})
