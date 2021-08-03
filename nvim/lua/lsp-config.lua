local nvim_lsp = require("lspconfig")
local util = require("lspconfig").util
require("lsp-kind")

-- Typescript--
-- Requires eslint_d (npm i -g eslint_d)
-- Requires typescript (npm i -g typescript)
-- Requires prettierd (npm i -g @fzousa/prettierd)
-- Requires typescript (npm i -g typescript-language-server)
-- Requires diagnosticls (npm i -g diagnostic-languageserver)
local format_async = function(err, _, result, _, bufnr)
  if err ~= nil or result == nil then
    return
  end
  if not vim.api.nvim_buf_get_option(bufnr, "modified") then
    local view = vim.fn.winsaveview()
    vim.lsp.util.apply_text_edits(result, bufnr)
    vim.fn.winrestview(view)
    if bufnr == vim.api.nvim_get_current_buf() then
      vim.api.nvim_command("noautocmd :update")
    end
  end
end

vim.lsp.handlers["textDocument/formatting"] = format_async

_G.lsp_organize_imports = function()
  local params = { command = "_typescript.organizeImports", arguments = { vim.api.nvim_buf_get_name(0) }, title = "" }
  vim.lsp.buf.execute_command(params)
end

local on_attach = function(client)
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspOrganize lua lsp_organize_imports()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
  vim.cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
  require"lsp_signature".on_attach({ bind = true, handler_opts = { border = "single" } })
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_exec(
      [[
      augroup LspAutocommands
        autocmd! * <buffer>
        autocmd BufWritePost <buffer> LspFormatting
      augroup END
    ]], true
    )
  end
end
nvim_lsp.tsserver.setup {
  root_dir = util.root_pattern("package.json"),
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
  end,
}
local filetypes = { tscss = "eslint", typescript = "eslint", typescriptreact = "eslint" }
local linters = {
  eslint = {
    debounce = 100,
    command = "eslint_d",
    sourceName = "eslint",
    rootPatterns = { ".eslintrc.js", "package.json" },
    args = { "--stdin", "--stdin-filename", "%filepath", "--format", "json" },
    parseJson = {
      line = "line",
      column = "column",
      endLine = "endLine",
      security = "severity",
      endColumn = "endColumn",
      errorsRoot = "[0].messages",
      message = "${message} [${ruleId}]",
    },
    securities = { [2] = "error", [1] = "warning" },
  },
}
local formatters = { prettier = { command = "prettierd", args = { "%filepath" } } }
local formatFiletypes = { typescript = "prettier", typescriptreact = "prettier" }
nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = vim.tbl_keys(filetypes),
  root_dir = util.root_pattern("package.json"),
  init_options = { filetypes = filetypes, linters = linters, formatters = formatters, formatFiletypes = formatFiletypes },
}
-- Typescript--

-- Lua--
-- Install ninja - yay -S ninja
-- Create luaformatter config - ~/.config/luaformatter/config.yaml
-- Install lua-language-server - https://github.com/sumneko/lua-language-server
-- Install lua/luarocks - https://github.com/luarocks/luarocks/wiki/Installation-instructions-for-Unix
-- Install efm-language-server - (requires Go) - go get github.com/mattn/efm-langserver
-- Install luaformatter - (requires Cmake) sudo luarocks install --server=https://luarocks.org/dev luaformatter
local luals_bin = "/home/arnamak/.current/lua-language-server/"
local sumneko_root_path = luals_bin
local sumneko_binary = "/home/arnamak/.current/lua-language-server/bin/Linux/lua-language-server"
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
nvim_lsp.sumneko_lua.setup {
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  root_dir = util.root_pattern(".lua-format"),
  settings = {
    Lua = {
      telemetry = { enable = false },
      diagnostics = { globals = { "vim" } },
      runtime = { version = "LuaJIT", path = runtime_path },
      workspace = { library = vim.api.nvim_get_runtime_file("", true), maxPreload = 6000, preloadFileSize = 10000 },
    },
  },
  vim.api.nvim_command([[autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)]]),
}
-- TODO: I should probably use one of efm or diagnosticls
nvim_lsp.efm.setup {
  filetypes = { "lua" },
  root_dir = util.root_pattern(".lua-format"),
  init_options = { documentFormatting = true },
  settings = { languages = { lua = { { formatCommand = "lua-format -i", formatStdin = true } } } },
}
-- Lua--

-- CSS--
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- nvim_lsp.cssls.setup {
--   capabilities = capabilities,
--   filetypes = {"css", "less", "scss", "tscss"},
--   settings = {css = {validate = true}, scss = {validate = true}, less = {validate = true}, tscss = {validate = false}}
-- }
-- CSS--

-- Docker--
-- vim.api.nvim_exec([[
--     au BufRead Dockerfile.* set filetype=dockerfile
--     au BufRead *.jss.ts set filetype=tscss | set syntax=typescript
--   ]], false)
-- nvim_lsp.dockerls.setup {filetypes = {"dockerfile"}}
-- Docker--

-- Bash--
-- nvim_lsp.bashls.setup {}
-- Bash--
