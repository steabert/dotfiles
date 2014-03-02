-- TypeScript / ESLint
local lsp = require("lspconfig")
local lspcfg = require("me/lsp")

-- support yarn PnP if present
local tsserver_path = ".yarn/sdks/typescript/bin/tsserver"
local tsserver_file = io.open(tsserver_path, "r")
if tsserver_file ~= nil then
  io.close(tsserver_file)
else
  tsserver_path = "tsserver"
end

lsp.tsserver.setup({
  on_attach = lspcfg.on_attach,
  cmd = {
    'typescript-language-server',
    '--tsserver-path',
    tsserver_path,
    '--stdio'
  },
  handlers = lspcfg.handlers,
})

lsp.eslint.setup({
  on_attach = lspcfg.on_attach,
  handlers = lspcfg.handlers,
})
