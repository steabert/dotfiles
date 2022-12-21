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
	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	on_attach = function(client, bufnr)
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	end,
	handlers = {
		["textDocument/publishDiagnostics"] = vim.lsp.with(
			vim.lsp.diagnostic.on_publish_diagnostics,
			{ virtual_text = false }
		),
	},
}

-- Bash
lsp.bashls.setup({
	on_attach = lspcfg.on_attach,
	handlers = lspcfg.handlers,
})

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
-- npm install -g graphql-lsp
lsp.graphql.setup({
	capabilities = lspcfg.capabilities,
	on_attach = lspcfg.on_attach,
	handlers = lspcfg.handlers,
})

-- Lua
lsp.lua_ls.setup({
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

-- Web
-- npm install -g \
-- 	vscode-json-language-server \
-- 	vscode-html-language-server \
-- 	vscode-eslint-language-server \
-- 	vscode-css-language-server \
-- 	typescript-language-server \
-- 	typescript

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
	commands = {
		TSServerOrganizeImports = {
			function()
				local params = {
					command = "_typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(0) },
				}
				vim.lsp.buf.execute_command(params)
			end,
			description = "Organize Imports",
		},
	},
	user_commands = {
		{
			name = "TSServerOrganizeImports",
			command = function()
				local params = {
					command = "_typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(0) },
				}
				vim.lsp.buf.execute_command(params)
			end,
			opts = {
				desc = "Organize Imports",
			},
		},
	},
})

lsp.eslint.setup({
	on_attach = lspcfg.on_attach,
	handlers = lspcfg.handlers,
})

-- YAML
-- npm install -g yaml-language-server
lsp.yamlls.setup({
	capabilities = lspcfg.capabilities,
	on_attach = lspcfg.on_attach,
	handlers = lspcfg.handlers,
	settings = {
		yaml = {
			hover = true,
			validate = true,
			schemaStore = {
				enable = true,
				url = "https://www.schemastore.org/api/json/catalog.json",
			},
			schemas = {
				["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.json"] = "schema.yaml",
			},
		},
	},
})

-- Null-ls (used for formatting)
local null_ls = require("null-ls")
local null_ls_utils = require("null-ls.utils")
null_ls.setup({
	debug = true,
	debounce = 250,
	sources = {
		null_ls.builtins.formatting.dprint.with({
			filetypes = {
				"javascript",
				"javascriptreact",
				"graphql",
				"graphqls",
				"typescript",
				"typescriptreact",
				"json",
				"markdown",
				"toml",
				"rust",
				"yaml",
				"yml",
			},
		}),
		-- null_ls.builtins.formatting.prettier.with({
		-- 	filetypes = { "graphql" },
		-- }),
		-- null_ls.builtins.formatting.prettier,
		-- null_ls.builtins.formatting.prettierd.with({
		-- 	PRETTIERD_LOCAL_PRETTIER_ONLY = 1,
		-- }),
		null_ls.builtins.formatting.stylua,
	},
	on_attach = function(client) end,
	root_dir = null_ls_utils.root_pattern(".git"),
})
