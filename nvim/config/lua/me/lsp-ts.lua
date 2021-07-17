-- TypeScript
local tsserver_path = '.yarn/sdks/typescript/bin/tsserver'
local tsserver_file = io.open(tsserver_path, 'r')
if tsserver_file ~= nil then
  io.close(tsserver_file)
else
  tsserver_path = 'tsserver'
end
require('lspconfig').tsserver.setup {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    require('completion').on_attach(client)
  end,
  cmd = {
    'typescript-language-server',
    '--tsserver-path',
    tsserver_path,
    '--stdio'
  },
  handlers = {
    -- disable diagnostics, we are using CoC for that (with better eslint
    -- support, but somehow worse navigation)
    ['textDocument/publishDiagnostics'] = function() end
  }
}
