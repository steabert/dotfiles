-- GraphQL
local lsp = require("lspconfig")
local lspcfg = require("me/lsp")

lsp.graphql.setup {
  capabilities = lspcfg.capabilities,
  on_attach = lspcfg.on_attach,
  handlers = lspcfg.handlers,
}
