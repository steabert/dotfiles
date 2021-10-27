-- Bicep
require('lspconfig').bicep.setup {
  on_attach = require('completion').on_attach,
  cmd = {'dotnet', '/home/stevenv/.azure/bicep-ls/Bicep.LangServer.dll'},
  -- handlers = {
  --   ['textDocument/publishDiagnostics'] = vim.lsp.with(
  --     vim.lsp.diagnostic.on_publish_diagnostics, {virtual_text = false})
  -- }
}
