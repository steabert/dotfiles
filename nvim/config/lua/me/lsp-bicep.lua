-- Bicep
local lsp = require("lspconfig")
local lspcfg = require("me/lsp")

lsp.bicep.setup {
  on_attach = lspcfg.on_attach,
  handlers = lspcfg.handlers,
  cmd = {'dotnet', '/home/stevenv/.azure/bicep-ls/Bicep.LangServer.dll'},
}
