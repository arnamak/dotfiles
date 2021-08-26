require("plugins")
require("lsp-config")
require("telescope-config")
require("file-tree")
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
require("dap-config")
require("dap-ui")

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
