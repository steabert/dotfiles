-- Go
local lsp = require("lspconfig")
local lspcfg = require("me/lsp")

lsp.gopls.setup {
  on_attach = lspcfg.on_attach,
  handlers = lspcfg.handlers,
}
