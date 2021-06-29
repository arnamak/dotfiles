execute pathogen#infect()
""" Quick Reference/Table of Contents
"""
"" User
"----------------------------------
" CoC - <leader> c
" ctrlp - <leader> t
" vim-eunuch - :<Cmd>
" vim-fzf-rg - <leader> g
" vim-commentary - <select_text> gc
"
"" Passive
"----------------------------------
"" Colors, syntax, linting
" lightline
" vim-lastplace
" vim-gitgutter
" vim-jsx-pretty
" vim-javascript
" challenger_deep
" comfortable-motion

" Vanilla
"----------------------------------
"" Colors
  syntax on
  set t_Co=256
  colorscheme challenger_deep
"" Undo
  set undofile
  set undodir=~/.config/nvim/.undo
"" Spacing
  set smarttab
  set expandtab
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
"" Appearance
  set hidden
  set number
  set nowrap
  set noshowmode
  set laststatus=2
"" Navigation
  set ttyfast
  set mouse=a
  set sidescroll=1
  set scrolloff=300
  set sidescrolloff=1
  nmap <LeftMouse> <nop>
  imap <LeftMouse> <nop>
  vmap <LeftMouse> <nop>
  nmap <2-LeftMouse> <nop>
"" Convenience
  set noswapfile
  set clipboard+=unnamedplus
  autocmd VimResized * :wincmd =
"" Folds
  let javaScript_fold=1
  set foldmethod=syntax
  set foldlevelstart=99
"" CoC
  set nobackup
  set shortmess+=c
  set nowritebackup
  set updatetime=1000

"----------------------------------
" /Vanilla Config

"" Mappings
  noremap :W :w
  let mapleader=" "
  imap <silent> kk <Esc>
  imap <silent> jj <Esc>:update<Enter>

"" Whitespace
  highlight ExtraWhitespace ctermbg=darkblue guibg=darkblue
  map <leader>T  :%s/\s\s*$//g<cr>
  match ExtraWhitespace /\s\+$/

"" User
"-------------------------------------------------------
" Linter
  let g:vim_jsx_pretty_colorful_config = 1

" CTRLP
  let g:ctrlp_map = '<leader>t'
  map <leader>v :CtrlPMRU<cr>
  map <leader>b :CtrlPBuffer<cr>
  let g:ctrlp_working_path_mode = 2
  set wildignore+=*.o,*.obj,.git,*.swp,tmp,*.jsx.html,*.pyc
  set runtimepath^=~/.config/nvim/bundle/ctrlp.vim/autoload/ctrlp.vim/plugin/
  let g:ctrlp_prompt_mappings = { 'PrtSelectMove("k")':   ['<c-u>', '<up>'] }
  let g:ctrlp_custom_ignore = '_site\|node_modules\|\.git$\|\.svn$|\.swp$|\.o$|'

" vim-commentary - <select_text> gc

" Passive
"------------------------------------------------
"" Lightline
  let g:lightline = {
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'cocstatus', 'currentfunction' ] ]
        \ },
        \ 'component_function': {
        \   'gitbranch': 'fugitive#head',
        \   'filename': 'LightlineFilename',
        \   'cocstatus': 'CocCurrentFunction',
        \ },
        \ }
  function! CocCurrentFunction()
      return get(b:, 'coc_current_function', '')
  endfunction
  function! LightlineFilename()
    let root = fnamemodify(get(b:, 'git_dir'), ':h')
    let path = expand('%:p')
    if path[:len(root)-1] ==# root
      return path[len(root)+1:]
    endif
    return expand('%')
  endfunction

autocmd FileType python map <buffer> <F2> :call flake8#Flake8()<CR>


" vim.fzf
set rtp+=~/.fzf
map <leader>g :Rg<CR>
let g:fzf_preview_window = 'right:60%'

"" Smooth Scrolling
let g:comfortable_motion_air_drag = 2.0
let g:comfortable_motion_friction = 200.0
let g:comfortable_motion_no_default_key_mappings = 1
nnoremap <silent> <C-e> :call comfortable_motion#flick(80)<CR>
nnoremap <silent> <C-y> :call comfortable_motion#flick(-80)<CR>
nnoremap <silent> <C-d> :call comfortable_motion#flick(150)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(-150)<CR>
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

"" CoC
let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-jest',
  \ 'coc-pairs',
  \ 'coc-eslint',
  \ 'coc-tsserver',
  \ 'coc-snippets',
  \ 'coc-prettier',
  \ ]

" Autocomplete
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
let g:coc_snippet_next = '<tab>'
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Documentation
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>


" Formatting
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
command! -nargs=0 Format :call CocAction('format')
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" CodeAction
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gd <Plug>(coc-definition)
xmap <leader>x <Plug>(coc-convert-snippet)
vmap <leader>a  <Plug>(coc-codeaction-selected)
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
autocmd CursorHold * silent call CocActionAsync('highlight')
nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>
nnoremap <leader>rt :call CocAction('runCommand', 'jest.projectTest')<CR>
nnoremap <leader>ft :call CocAction('runCommand', 'jest.fileTest', ['%'])<CR>
