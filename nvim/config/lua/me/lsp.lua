local lsp = require("lspconfig")

vim.diagnostic.config({
	float = {
		format = function(diagnostic)
			return string.format(
				"%s [%s]",
				diagnostic.message,
				diagnostic.source == "eslint" and diagnostic.user_data.lsp.code or diagnostic.source
			)
		end,
	},
})

-- LSP base configurations
local lspcfg = {
	capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	end,
	handlers = {
		["textDocument/publishDiagnostics"] = vim.lsp.with(
			vim.lsp.diagnostic.on_publish_diagnostics,
			{ virtual_text = false }
		),
	},
}

-- Bicep
lsp.bicep.setup({
	capabilities = lspcfg.capabilities,
	on_attach = lspcfg.on_attach,
	handlers = lspcfg.handlers,
	cmd = { "dotnet", "/home/stevenv/.azure/bicep-ls/Bicep.LangServer.dll" },
})

-- Go
lsp.gopls.setup({
	capabilities = lspcfg.capabilities,
	on_attach = lspcfg.on_attach,
	handlers = lspcfg.handlers,
})

-- GraphQL
lsp.graphql.setup({
	capabilities = lspcfg.capabilities,
	on_attach = lspcfg.on_attach,
	handlers = lspcfg.handlers,
})

-- Lua
lsp.sumneko_lua.setup({
	capabilities = lspcfg.capabilities,
	on_attach = lspcfg.on_attach,
	handlers = lspcfg.handlers,
	-- cmd = {'lua-language-server', '-E', '/usr/share/lua-language-server/main.lua'},
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = { enable = false },
		},
	},
})

-- Python
lsp.pylsp.setup({
	capabilities = lspcfg.capabilities,
	on_attach = lspcfg.on_attach,
	handlers = lspcfg.handlers,
})

-- Rust
lsp.rust_analyzer.setup({
	capabilities = lspcfg.capabilities,
	on_attach = lspcfg.on_attach,
	handlers = lspcfg.handlers,
})

-- TypeScript / ESLint
-- support yarn PnP if present
local tsserver_path = ".yarn/sdks/typescript/bin/tsserver"
local tsserver_file = io.open(tsserver_path, "r")
if tsserver_file ~= nil then
	io.close(tsserver_file)
else
	tsserver_path = "tsserver"
end
lsp.tsserver.setup({
	capabilities = lspcfg.capabilities,
	on_attach = lspcfg.on_attach,
	cmd = {
		"typescript-language-server",
		"--tsserver-path",
		tsserver_path,
		"--stdio",
	},
	handlers = lspcfg.handlers,
})

lsp.eslint.setup({
	on_attach = lspcfg.on_attach,
	handlers = lspcfg.handlers,
})

-- YAML
lsp.yamlls.setup({
	capabilities = lspcfg.capabilities,
	on_attach = lspcfg.on_attach,
	handlers = lspcfg.handlers,
	settings = {
		yaml = {
			["https://json.schemastore.org/github-workflow"] = "/.github/workflows/*",
		},
	},
})
