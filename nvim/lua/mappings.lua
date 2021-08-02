local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--Table of Contents--
local native = {
  save_quit = "jj"
}
local files = {
  recent = "<Leader>v",
  buffer = "<Leader>b",
  browse = "<Leader>n"
}
local hop = {
  normal = "~",
  hint_1 = "<C-Space>",
  hint_2 = "<Leader>f"
}
local compe = {
  quit_all = "<C-e>",
  complete = "<Tab>",
  confirms = "<CR>",
  backward = "<S-Tab>",
  alt_conf = "<C-Space>"
}
local telescope = {
  oldfs = "tt",
  buffs = "ty",
  files = "tu",
  fuzzy = "tf",
  htags = "th",
  nkeys = "tk",
  refer = "tr",
  gitbr = "tb",
  built = "ti"
}
----LSP----
local show = {
  docs = "K",
  find = "gh",
  defs = "gj",
  sign = "gs"
}
local goto = {
  defs = "gd",
  type = "gt"
}
local du = {
  rename = "gr",
  caline = "gy",
  action = "gw"
}
----LSP----

--Native--
map("i", native.save_quit, [[<Esc>:w<CR>]])
--Native--

--Files--
map("n", files.buffer, [[:JABSOpen<CR>]])
map("n", files.browse, [[:NvimTreeToggle<CR>]])
--Files--

--Hop--
map("n", hop.normal, [[:lua require'hop'.hint_char1()<CR>]])
map("n", hop.hint_1, [[:lua require'hop'.hint_words()<CR>]])
map("n", hop.hint_2, [[:lua require'hop'.hint_char2()<CR>]])
--Hop--

--LSP--
map("n", goto.defs, [[:LspDef<CR>]])
map("n", goto.type, [[:LspTypeDef<CR>]])
map("n", du.rename, [[:lua require('lspsaga.rename').rename()<CR>]])
map("n", show.find, [[:lua require('lspsaga.provider').lsp_finder()<CR>]])
map("n", show.docs, [[:lua require('lspsaga.hover').render_hover_doc()<CR>]])
map("n", du.action, [[:lua require('lspsaga.codeaction').code_action()<CR>]])
map("n", show.defs, [[:lua require('lspsaga.provider').preview_definition()<CR>]])
map("n", show.sign, [[:lua require('lspsaga.signaturehelp').signature_help()<CR>]])
map("n", du.caline, [[:lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>]])
map("v", du.action, [[:<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>]])
--LSP--

--Completion--
local completion_opts = { expr = true }
map("i", compe.quit_all, [[compe#close()]], completion_opts)
map("i", compe.complete, [[v:lua.tab_complete()]], completion_opts)
map("s", compe.complete, [[v:lua.tab_complete()]], completion_opts)
map("i", compe.backward, [[v:lua.s_tab_complete()]], completion_opts)
map("s", compe.backward, [[v:lua.s_tab_complete()]], completion_opts)
map("i", compe.confirms, [[compe#confirm({ 'keys': '<CR>', 'select': v:true })]], completion_opts)
map("i", compe.alt_conf, [[compe#confirm({ 'keys': '<CR>', 'select': v:true })]], completion_opts)
--Completion--

--Telescope--
map("n", telescope.buffs, [[:lua require('telescope.builtin').buffers()<CR>]])
map("n", telescope.built, [[:lua require('telescope.builtin').builtin()<CR>]])
map("n", telescope.nkeys, [[:lua require('telescope.builtin').keymaps()<CR>]])
map("n", telescope.oldfs, [[:lua require('telescope.builtin').oldfiles()<CR>]])
map("n", telescope.fuzzy, [[:lua require('telescope.builtin').live_grep()<CR>]])
map("n", telescope.htags, [[:lua require('telescope.builtin').help_tags()<CR>]])
map("n", telescope.files, [[:lua require('telescope.builtin').find_files()<CR>]])
map("n", telescope.gitbr, [[:lua require('telescope.builtin').git_branches()<CR>]])
map("n", telescope.refer, [[:lua require('telescope.builtin').lsp_references()<CR>]])
--Telescope--
