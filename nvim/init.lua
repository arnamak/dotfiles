require("plugins")
require("lsp-config")
require("lspsaga-config")
require("telescope-config")
require("file-tree")
require("trouble-config")
require("editor-settings")
require("compe-config")
require("kommentary-config")
require("lastplace")
require("mappings")
require("gitsigns-config")
require("spectre-config")
require("term-config")
require("lightspeed-config")
require("stay-centered")
require("onedark").setup()
require("iswap-config")

--
vim.api.nvim_command(
  [[
    autocmd TermOpen * :lua require('util.change-terminal-ftype').changeTerminalFileType()
  ]]
)
-- vim.api.nvim_exec(
--   [[
--     augroup remember_folds
--       autocmd!
--       autocmd BufWinLeave * :call mkview 1
--       autocmd BufWinEnter * silent! :call loadview 1
--     augroup END
--   ]], true
-- )
