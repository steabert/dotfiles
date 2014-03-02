-- GraphQL
local lsp = require("lspconfig")
local lspcfg = require("me/lsp")

lsp.graphql.setup {
  on_attach = lspcfg.on_attach,
  handlers = lspcfg.handlers,
}
