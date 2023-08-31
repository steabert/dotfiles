local formatter = require("formatter")
local util = require("formatter.util")

local stylua = require("formatter.filetypes.lua").stylua

local dprint = function()
	return {
		exe = "dprint",
		args = { "fmt", "--stdin", util.escape_path(util.get_current_buffer_file_path()) },
		stdin = true,
	}
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
		["*"] = function()
			vim.lsp.buf.format({ async = true })
		end,
	},
})
