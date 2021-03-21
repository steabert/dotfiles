-- TypeScript
require('lspconfig').tsserver.setup{
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = false
		require('completion').on_attach(client)
	end,
	cmd={
		"typescript-language-server",
		"--tsserver-path", ".yarn/sdks/typescript/bin/tsserver",
		"--stdio"
	},
	handlers = { 
		["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics, {
			virtual_text = false
		})
	}
}
