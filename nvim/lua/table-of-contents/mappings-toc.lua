local M = {}
-- Table of Contents--
M.files = {
  recent = "<Leader>v",
  buffer = "<Leader>b",
  browse = "<Leader>n",
}
M.hop = {
  normal = "~",
  hint_1 = "<C-Space>",
  hint_2 = "<Leader>f",
}
M.compe = {
  confirms = "<CR>",
  quit_all = "<C-e>",
  complete = "<Tab>",
  backward = "<S-Tab>",
  alt_conf = "<C-Space>",
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
}

M.octo_files = {
  next = "j",
  prev = "k",
  select = "<CR>",
  refresh = "<C-r>",
}
M.issue = {
  list = "<space>li",
}
M.octo = {
  reload = "<C-r>",
  browser = "<C-b>",
  copy_url = "<C-y>",
  add_comment = "<space>co",
  next_comment = "<leader>n",
  prev_comment = "<leader>N",
  delete_comment = "<space>cdo",
}
M.review = {
  focus = "<C-e>",
  files = "<C-E>",
  approve = "<C-a>",
  comment = "<C-m>",
  next_thread = "]t",
  prev_thread = "[t",
  close_tab = "<C-c>",
  next_entry = "<leader>sn",
  prev_entry = "<leader>sp",
  add_suggestion = "<leader>sa",
}
M.pull_request = {
  merge = "<C-x>pm",
  checkout = "<space>gc",
  list_commits = "<space>pc",
  show_pr_diff = "<space>pd",
  remove_reviewer = "<space>vd",
}

return M
