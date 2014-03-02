-- Lua
local lsp = require("lspconfig")
local lspcfg = require("me/lsp")

lsp.sumneko_lua.setup {
  on_attach = lspcfg.on_attach,
  handlers = lspcfg.handlers,
  -- cmd = {'lua-language-server', '-E', '/usr/share/lua-language-server/main.lua'},
  cmd = {'lua-language-server'},
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';')
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
        }
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {enable = false}
    }
  },
}
