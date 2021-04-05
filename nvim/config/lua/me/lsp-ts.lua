-- TypeScript
require('lspconfig').tsserver.setup {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    require('completion').on_attach(client)
  end,
  cmd = {
    'typescript-language-server',
    '--tsserver-path',
    '.yarn/sdks/typescript/bin/tsserver',
    '--stdio'
  },
  handlers = {
    -- disable diagnostics, we are using CoC for that (with better eslint
    -- support, but somehow worse navigation)
    ['textDocument/publishDiagnostics'] = function() end
  }
}
