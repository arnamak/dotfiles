local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

map("i", "jj",            [[<Esc>:w<CR>]], opt)
map("n", "<Leader>v",     [[:CtrlPMRU <CR>]], opt)
map("n", "<Leader>n",     [[:NvimTreeToggle<CR>]], opt)
map("n", "<C-Space>",     [[:lua require'hop'.hint_words()<cr>]], opt)
map("n", "~",             [[:lua require'hop'.hint_char1()<cr>]], opt)
map("n", "<Leader>f",     [[:lua require'hop'.hint_char2()<cr>]], opt)

local silent_noremap = { silent = true, noremap = true }
map("n", "<Leader>gh",    [[:lua require('lspsaga.provider').lsp_finder()<cr>]], silent_noremap)
map("n", "<Leader>ca",    [[:lua require('lspsaga.codeaction').code_action()<cr>]], silent_noremap)
map("v", "<Leader>ca",    [[:<C-U>lua require('lspsaga.codeaction').range_code_action()<cr>]], silent_noremap)
map("n", "K",             [[:lua require('lspsaga.hover').render_hover_doc()<CR>]], silent_noremap)
map("n", "<Leader>s",    [[:lua require('lspsaga.signaturehelp').signature_help()<CR>]], silent_noremap)
map("n", "<Leader>r",    [[:lua require('lspsaga.rename').rename()<CR>]], silent_noremap)
map("n", "<Leader>h",    [[:lua require('lspsaga.provider').preview_definition()<CR>]], silent_noremap)
map("n", "<Leader>y",    [[:lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>]], silent_noremap)
