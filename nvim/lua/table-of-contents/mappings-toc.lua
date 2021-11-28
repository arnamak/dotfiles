local M = {}
-- Table of Contents--
M.files = {
  -- recent = "<Leader>v",
  -- buffer = "<Leader>b",
  browse = "<Leader>n",
}
M.compe = {
  confirms = "<CR>",
  quit_all = "<C-e>",
  complete = "<Tab>",
  backward = "<S-Tab>",
}
M.telescope = {
  mru_file = "tt",
  buf_file = "ty",
  all_file = "tu",
  rip_grep = "tf",
  tag_help = "th",
  map_norm = "tk",
  lsp_refs = "tr",
  git_bran = "tb",
  builtins = "ti",
}
M.trouble = {
  open_close = "te",
  -- references = "tr",
  page_diags = "td",
  dirs_diags = "tw",
  -- quickfixes = "tq",
  -- locs_lists = "tl",
}
M.show = {
  lsp_docs = "K",
  lsp_find = "gh",
  lsp_defs = "gj",
  lsp_sigs = "gs",
}
M.action = {
  rename = "gr",
  line_d = "gy",
  codeac = "gw",
}
M.jump = {
  lsp_defs = "gd",
  lsp_type = "gt",
}
M.native = {
  insert_save_and_quit = "jj",
  insert_move_cursor_l = "<C-s>",
  insert_move_cursor_r = "<C-f>",
}
M.fterm = {
  toggle = "<A-i>",
  lzygit = "<A-g>",
}
M.iswap = {
  swapselect = "<A-d>",
}

return M
