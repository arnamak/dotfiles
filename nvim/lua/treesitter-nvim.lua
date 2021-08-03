local M = {}
local npairs = require("nvim-autopairs")
local endwise = require("nvim-autopairs.ts-rule").endwise

npairs.setup(
  {
    check_ts = true,
    ts_config = {
      lua = { "string" },
      javascript = { "template_string" },
      typescript = { "template_string" },
      javascriptreact = { "template_string" },
      typescriptreact = { "template_string" },
    },
  }
)
npairs.add_rules(
  {
    endwise(
      "arrow_function", "arguments", "body", "variable_declarator", "return_statement", "jsx_element",
      "jsx_self_closing_element"
    ),
  }
)
require("nvim-autopairs.completion.compe").setup({ map_cr = true, map_complete = true })

M.config = function()
  local config = require("nvim-treesitter.configs")
  config.setup {
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
    context_commentstring = {
      enable = true,
      config = {
        css = "// %s",
        comment = "// %s",
        __default = "// %s",
        jsx_attribute = "// %s",
        jsx_element = "{/* %s */}",
        jsx_fragment = "{/* %s */}",
      },
    },
    indent = { enable = true },
    autotag = { enable = true },
    autopairs = { enable = true },
    highlight = { enable = true, use_languagetree = true },
    rainbow = { enable = true, extended_mode = true, max_file_lines = 1000000 },
  }
end

return M
