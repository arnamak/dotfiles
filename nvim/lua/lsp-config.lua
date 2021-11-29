local nvim_lsp = require("lspconfig")
local util = require("lspconfig").util
-- Formatters
local eslintConfig = require("lsp/efm/eslint")
local prettierConfig = require("lsp/efm/prettier")
local luaConfig = require("lsp/efm/lua")
-- Plugins
local lsp_status = require("lsp-status")
lsp_status.config(
  {
    kind_labels = {},
    indicator_errors = "",
    indicator_warnings = "",
    status_symbol = "",
    indicator_hint = "❗",
    indicator_info = "🛈",
    indicator_ok = "",
  }
)
lsp_status.register_progress()
require("lsp-kind")

-- Typescript--
-- Requires eslint_d (npm i -g eslint_d)
-- Requires typescript (npm i -g typescript)
-- Requires prettierd (npm i -g @fsouza/prettierd)
-- Requires typescript-language-server (npm i -g typescript-language-server)
-- Install efm-language-server - (requires Go) - go get github.com/mattn/efm-langserver
-- npm i -g eslint_d typescript typescript-language-server @fsouza/prettierd
vim.lsp.handlers["textDocument/formatting"] = function(err, result, ctx)
  -- https://github.com/lukas-reineke/dotfiles/blob/0d0b5e6112ade48de5f2d652cc2b54cb16950e57/vim/lua/lsp/handlers.lua#L1
  if err ~= nil or result == nil then
    return
  end
  if vim.api.nvim_buf_get_var(ctx.bufnr, "init_changedtick") == vim.api.nvim_buf_get_var(ctx.bufnr, "changedtick") then
    local view = vim.fn.winsaveview()
    vim.lsp.util.apply_text_edits(result, ctx.bufnr)
    vim.fn.winrestview(view)
    if ctx.bufnr == vim.api.nvim_get_current_buf() then
      vim.b.saving_format = true
      vim.cmd [[update]]
      vim.b.saving_format = false
    end
  end
end

_G.lsp_organize_imports = function()
  local params = { command = "_typescript.organizeImports", arguments = { vim.api.nvim_buf_get_name(0) }, title = "" }
  vim.lsp.buf.execute_command(params)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local on_attach = function(client)
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua require('lsp-formatting').format()")
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
  client.capabilities = capabilities
  lsp_status.on_attach(client)
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
    lsp_status.on_attach(client)
    on_attach(client)
  end,
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
-- Lua--


-- EFM--
nvim_lsp.efm.setup(
  {
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = { documentFormatting = true },
    root_dir = util.root_pattern("package.json", ".lua-format"),
    settings = {
      rootMarkers = { "package.json", ".lua-format" },
      lintDebounce = 100,
      languages = {
        typescript = { prettierConfig, eslintConfig },
        typescriptreact = { prettierConfig, eslintConfig },
        lua = { luaConfig },
        -- javascript = { prettierConfig, eslintConfig },
        -- javascriptreact = { prettierConfig, eslintConfig },
      },
      filetypes = {
        "typescript",
        "typescriptreact",
        "lua",
        -- "javascript", "javascriptreact",
      },
    },
  }
)
-- EFM--
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
