local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

map("n", "<Leader>n", [[ <Cmd> set nu!<CR>]], opt)
map("n", "<Leader>v", [[:CtrlPMRU <CR>]], opt)
