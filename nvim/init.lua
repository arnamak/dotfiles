require("plugins")
require("lsp-config")
require("telescope-config")
require("file-tree")
require("editor-settings")
require("compe-config")
local saga = require("lspsaga")
saga.init_lsp_saga()
require("mappings")

vim.g.mapleader = " "
vim.g.filetype = "plugin indent on"
vim.g.onedark_style = "deep"
require("onedark").setup()
