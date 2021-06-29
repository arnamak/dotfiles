local M = {}

M.config = function()
  local ts_config = require("nvim-treesitter.configs")

  ts_config.setup {
    ensure_installed = {
      "tsx",
      "yaml",
      "toml",
      "scss",
      "graphql",
      "typescript",
      "javascript",
      "html",
      "css",
      "bash",
      "lua",
      "json",
    },
    highlight = {
      enable = true,
      use_languagetree = true
    },
    indent = {
      enable = true
    }
  }
end

return M
