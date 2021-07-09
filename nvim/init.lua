require("editor-settings")
require("plugins")

local g = vim.g
g.mapleader = " "
g.filetype = "plugin indent on"
g.onedark_style = "deep"
require("onedark").setup()
require("mappings")


local sumneko_root_path = '/home/arnamak/.current/lua-language-server/'
local sumneko_binary = '/home/arnamak/.current/lua-language-server/bin/Linux/lua-language-server'
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require("lspconfig").sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
require("lspconfig").tsserver.setup {
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "tscss" }
}
require("lspconfig").bashls.setup{}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require("lspconfig").cssls.setup {
  capabilities = capabilities,
  filetypes = { "css", "less", "scss", "tscss" },
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
    tscss = { validate = false },
  },
}
require("lspconfig").dockerls.setup {
  filetypes = { "dockerfile" }
}

vim.api.nvim_exec(
  [[
    au BufRead Dockerfile.* set filetype=dockerfile
    au BufRead *.jss.ts set filetype=tscss | set syntax=typescript
  ]], false)
