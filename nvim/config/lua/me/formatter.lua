local formatter = require("formatter")
local util = require("formatter.util")

local goimports = require("formatter.filetypes.go").goimports
local stylua = require("formatter.filetypes.lua").stylua

local dprint = function()
	return {
		exe = "dprint",
		args = { "fmt", "--stdin", util.get_current_buffer_file_extension() },
		stdin = true,
	}
end

local lsp = function()
	vim.lsp.buf.format({ async = true })
end

formatter.setup({
	filetype = {
		graphql = { dprint },
		graphqls = { dprint },
		javascript = { dprint },
		javascriptreact = { dprint },
		json = { dprint },
		lua = { stylua },
		markdown = { dprint },
		rust = { dprint },
		toml = { dprint },
		typescript = { dprint },
		typescriptreact = { dprint },
		yaml = { dprint },
		yml = { dprint },
		go = { goimports },
	},
})
