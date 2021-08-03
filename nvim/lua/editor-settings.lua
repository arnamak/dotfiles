local opt = vim.o
local buf = vim.bo
local win = vim.wo

-- Global
opt.mouse = "a" -- Allow mouse in all modes (other values: "n", "v", "i", etc)
opt.ruler = false -- Displays cursor line number and position (3,67) in the statusline
opt.cmdheight = 1 -- Number of screen lines to use for the command-line
opt.laststatus = 2 -- Always display the status line
opt.sidescroll = 1 -- Defines the min amount of columns the screen will move on a horizontal scroll
opt.scrolloff = 0 -- Defines how far "off" you can scroll
opt.undofile = true -- Store undo history
opt.smarttab = false -- When on, adheres to shiftwidth when at the start of the line
opt.smartcase = true -- Ignore case when the pattern is lowercase, don't ignore uppercase
opt.updatetime = 251 -- Update interval for gitsigns
opt.splitbelow = true -- Allow a tab to be opened in a horizontal split
opt.splitright = true -- Allow a tab to be opened in a vertical split
opt.sidescrolloff = 1 -- Defines the min amount of columns around the cursor
opt.startofline = false -- Uncertain what this actually does. My observation, inserting not-SOL puts you SOL. Investigate normal mode.
opt.guifont = "nonicons" -- Icon font. Might be unnecessary
opt.termguicolors = true -- Allow 24-bit RGB color
opt.maxmempattern = 10000 -- Maximum amount of memory (KB) used for pattern matching
opt.clipboard = "unnamedplus" -- Access xclip (system) clipboard (requires xclip)
opt.backspace = "indent,eol,start" -- More intuitive backspace behavior in insert mode
opt.undodir = "/home/arnamak/.config/nvim/.undo" -- Directory where undo history is stored

-- Window
win.wrap = false -- Disable word wrap
win.number = true -- Display line numbers
win.numberwidth = 2 -- Width of the number column
win.cursorline = true -- Highlight the screen line of the cursor
win.signcolumn = "yes" -- Always show the sign column
win.foldmethod = "syntax"

-- Buffer
opt.tabstop = 2 -- Within a buffer, the space given to a tab
opt.shiftwidth = 2 -- How many columns a > will move
opt.softtabstop = 2 -- Whatever a "soft" tab is, this is how many spaces it is.
opt.expandtab = true -- Use spaces for tabs in insert mode
opt.swapfile = false -- Disable swap files
opt.smartindent = true -- Autoindenting when starting a new line (should this be turned off? Re: LSP)

vim.g.loaded_tar = 1 -- Disable vim tar plugin
vim.g.loaded_spec = 1 -- Disable weird buffer options
vim.g.loaded_gzip = 1 -- Disable vim gzip plugin
vim.g.loaded_netrw = 1 -- Disable network editing (may want to re-enable)
vim.g.loaded_matchit = 1 -- Enable using % key to find matching closing bracket
vim.g.loadedTarPlugin = 1 -- Disable vim tar plugin
vim.g.loaded_zipPlugin = 1 -- Disable vim zip plugin
vim.g.loaded_matchparen = 1 -- Disable matching parens (will probably be handled by a plugin)
vim.g.loaded_netrwPlugin = 1 -- Disable network editing (may want to re-enable)
vim.g.loaded_2html_plugin = 1 -- Disable conversion of the entire vim file to html?

local M = {}
M.blankline = function()
  vim.g.indentLine_enabled = 1
  vim.g.indent_blankline_char = "▏"
  vim.g.indent_blankline_use_treesitter = true
  vim.g.indent_blankline_show_first_indent_level = false
  vim.g.indent_blankline_buftype_exclude = { "terminal" }
  vim.g.indent_blankline_show_trailing_blankline_indent = false
  vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
end
return M
