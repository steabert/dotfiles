-- YAML
require('lspconfig').yamlls.setup({
  on_attach = require('completion').on_attach,
  handlers = {
    ['textDocument/publishDiagnostics'] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {virtual_text = false})
  },
  settings = {
    yaml = {
      ['https://json.schemastore.org/github-workflow'] = '/.github/workflows/*'
    }
  }
})
