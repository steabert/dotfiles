local defaultHandlers = { 
	["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false
	})
}
local attach_compl = require('completion').on_attach
local lspconfig = require('lspconfig')

-- Go
lspconfig.gopls.setup{
	on_attach = attach_compl,
	handlers = defaultHandlers
}

-- TypeScript
lspconfig.tsserver.setup{
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = false
		attach_compl(client)
	end,
	cmd={
		"typescript-language-server",
		"--tsserver-path", ".yarn/sdks/typescript/bin/tsserver",
		"--stdio"
	},
	handlers = defaultHandlers
}
