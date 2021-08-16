local M = {}
function M.changeTerminalFileType()
  vim.api.nvim_command("setlocal filetype=term ")
end
return M
