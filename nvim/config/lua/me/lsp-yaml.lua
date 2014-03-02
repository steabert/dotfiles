-- YAML
local lsp = require("lspconfig")
local lspcfg = require("me/lsp")

lsp.yamlls.setup({
  on_attach = lspcfg.on_attach,
  handlers = lspcfg.handlers,
  settings = {
    yaml = {
      ['https://json.schemastore.org/github-workflow'] = '/.github/workflows/*'
    }
  }
})
