local map = require("util.map")
local toc = require("table-of-contents.mappings-toc")

-- Scroll at start of line
map("n", "5", [[j0]])
map("n", "6", [[k0]])
map("n", "H", [[zh]])
map("n", "L", [[zl]])
map("v", "H", [[zh]])
map("v", "L", [[zl]])
---- Undo breakpoints (`u` will undo until one of these chars and stop until pressed again)
map("i", ",", [[,<c-g>u]])
map("i", ".", [[.<c-g>u]])
map("i", "!", [[!<c-g>u]])
map("i", "?", [[?<c-g>u]])
---- Move selection up/down
map("v", "J", [[:m '>+1<CR>gv=gv]])
map("v", "K", [[:m '<-2<CR>gv=gv]])
---- Misc
map("i", toc.native.insert_save_and_quit, [[<Esc>]])
map("i", toc.native.insert_move_cursor_l, [[<Left>]])
map("i", toc.native.insert_move_cursor_r, [[<Right>]])
-- Native--
-- Files--
-- map("n", toc.files.buffer, [[:JABSOpen<CR>]])
map("n", toc.files.browse, [[:NvimTreeToggle<CR>]])
-- Files--
-- Lazygit--
map("n", toc.fterm.toggle, [[:lua require('FTerm').toggle()<CR>]])
map("t", toc.fterm.toggle, [[:lua require('FTerm').toggle()<CR>]])
map("n", toc.fterm.lzygit, [[:lua require('FTerm')__fterm_lazygit()<CR>]])
map("t", toc.fterm.lzygit, [[:lua require('FTerm')__fterm_lazygit()<CR>]])
-- -- Lazygit--
-- LSP--
map("n", toc.jump.lsp_defs, [[:LspDef<CR>]])
map("n", toc.jump.lsp_type, [[:LspTypeDef<CR>]])
map("n", toc.action.rename, [[:lua require('lspsaga.rename').rename()<CR>]])
map("n", toc.show.lsp_find, [[:lua require('lspsaga.provider').lsp_finder()<CR>]])
map("n", toc.show.lsp_docs, [[:lua require('lspsaga.hover').render_hover_doc()<CR>]])
map("n", toc.action.codeac, [[:lua require('lspsaga.codeaction').code_action()<CR>]])
map("n", toc.show.lsp_defs, [[:lua require('lspsaga.provider').preview_definition()<CR>]])
map("n", toc.show.lsp_sigs, [[:lua require('lspsaga.signaturehelp').signature_help()<CR>]])
map("n", toc.action.line_d, [[:lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>]])
map("v", toc.action.codeac, [[:<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>]])
-- LSP--
-- Telescope--
map("n", toc.telescope.buf_file, [[:lua require('telescope.builtin').buffers()<CR>]])
map("n", toc.telescope.builtins, [[:lua require('telescope.builtin').builtin()<CR>]])
map("n", toc.telescope.map_norm, [[:lua require('telescope.builtin').keymaps()<CR>]])
map("n", toc.telescope.mru_file, [[:lua require('telescope.builtin').oldfiles()<CR>]])
map("n", toc.telescope.rip_grep, [[:lua require('telescope.builtin').live_grep()<CR>]])
map("n", toc.telescope.tag_help, [[:lua require('telescope.builtin').help_tags()<CR>]])
map("n", toc.telescope.all_file, [[:lua require('telescope.builtin').find_files()<CR>]])
map("n", toc.telescope.git_bran, [[:lua require('telescope.builtin').git_branches()<CR>]])
map("n", toc.telescope.lsp_refs, [[:lua require('telescope.builtin').lsp_references()<CR>]])
-- Telescope--
-- Trouble--
map("n", toc.trouble.open_close, [[:TroubleToggle<CR>]])
-- map("n", toc.trouble.locs_lists, [[:Trouble loclist<CR>]])
-- map("n", toc.trouble.quickfixes, [[:Trouble quickfix<CR>]])
-- map("n", toc.trouble.references, [[:Trouble lsp_references<CR>]])
map("n", toc.trouble.page_diags, [[:Trouble lsp_document_diagnostics<CR>]])
map("n", toc.trouble.dirs_diags, [[:Trouble lsp_workspace_diagnostics<CR>]])
-- Trouble--
-- Completion--
local completion_opts = { silent = true, expr = true }
map("i", toc.compe.complete, [[v:lua.tab_complete()]], completion_opts)
map("s", toc.compe.complete, [[v:lua.tab_complete()]], completion_opts)
map("i", toc.compe.backward, [[v:lua.s_tab_complete()]], completion_opts)
map("s", toc.compe.backward, [[v:lua.s_tab_complete()]], completion_opts)
map("i", toc.compe.confirms, [[compe#confirm({ 'keys': '<CR>', 'select': v:true })]], completion_opts)
-- Completion--
-- iSwap--
map("n", toc.iswap.swapselect, [[:ISwapWith<CR>]])
-- iSwap--
