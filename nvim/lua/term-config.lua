require"FTerm".setup(
  {
    dimensions = { height = 0.8, width = 0.8, x = 0.5, y = 0.5 },
    border = "single", -- or 'double'
  }
)
local term = require("FTerm.terminal")
local lazygit = term:new():setup({ cmd = "lazygit", dimensions = { height = 0.9, width = 0.9 } })
function _G.__fterm_lazygit()
  lazygit:toggle()
end
