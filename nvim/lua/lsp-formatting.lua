local M = {}

local format_disabled_var = function()
  return string.format("format_disabled_%s", vim.bo.filetype)
end
local format_options_var = function()
  return string.format("format_options_%s", vim.bo.filetype)
end

M.format = function()
  if not vim.b.saving_format and not vim.g[format_disabled_var()] then
    vim.b.init_changedtick = vim.b.changedtick
    vim.lsp.buf.formatting(vim.g[format_options_var()] or {})
  end
end

return M
