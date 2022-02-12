-- YAML
local lsp = require("lspconfig")
local lspcfg = require("me/lsp")

lsp.yamlls.setup({
  capabilities = lspcfg.capabilities,
  on_attach = lspcfg.on_attach,
  handlers = lspcfg.handlers,
  settings = {
    yaml = {
      ['https://json.schemastore.org/github-workflow'] = '/.github/workflows/*'
    }
  }
})
