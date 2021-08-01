require("plugins")
require("lsp-config")
require("file-tree")
require("editor-settings")
require("compe-config")
local saga = require("lspsaga")
saga.init_lsp_saga()

local g = vim.g
g.mapleader = " "
g.filetype = "plugin indent on"
g.onedark_style = "deep"
require("onedark").setup()
require("mappings")

vim.api.nvim_exec([[
    au BufRead Dockerfile.* set filetype=dockerfile
    au BufRead *.jss.ts set filetype=tscss | set syntax=typescript
  ]], false)
