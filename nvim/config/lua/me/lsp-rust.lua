-- Rust
local lsp = require("lspconfig")
local lspcfg = require("me/lsp")

lsp.rust_analyzer.setup({
	capabilities = lspcfg.capabilities,
	on_attach = lspcfg.on_attach,
	handlers = lspcfg.handlers,
})
