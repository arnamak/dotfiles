execute pathogen#infect()

""" Quick Reference/Table of Contents
"""
"" User
"--------------------------------
" ctrlp - <leader> t
" vim-eunuch - :<Cmd>
" vim-fzf - <leader> r
" nerdtree - <leader> e
" vim-tbone - <leader> y/p
" vim-rhubarb - <leader> G
" vim-yankstack - <leader> p/P *
" vim-commentary - <select_text> gc
" vim-fugitive - <leader> gco/gad/gcm/q
"
" " Passive
" -------------------------------
"" Colors, syntax, linting
" black
" vim-js
" vim-haml
" asyncrun
" lightline
" elementary
" vim-flake8
" vim-endwise
" vim-gitgutter
" vim-lastplace
" vim-javascript
"" Configuration
" vim-jsx-pretty
"
"" absent, but may want to add back later
" vim-rails
" vim-test
" vimux

" Vanilla configurations
  syntax on
  colorscheme elementary
  set t_Co=256
  set undofile " persist undo history after closing vim
  set undodir=~/.config/nvim/.undo
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
  set smarttab
  set expandtab
  set number
  set nowrap
  set backspace=indent,eol,start " more intuitive navigation when hitting backspace
  set laststatus=2
  set noshowmode
  set scrolloff=300
  set sidescrolloff=1
  set sidescroll=1
  set ttyfast
  noremap <Up> <NOP>
  noremap <Down> <NOP>
  noremap <Left> <NOP>
  noremap <Right> <NOP
  autocmd VimResized * :wincmd =
  let g:python3_host_prog = '$HOME/.pyenv/versions/3.7.6/bin/python'

" mappings
" typing 'jj' while in insert mode saves your file and enters normal mode
  imap <silent> jj <Esc>:update<Enter>
  let mapleader=" "

" whitespace
  :highlight ExtraWhitespace ctermbg=darkblue guibg=darkblue
  :match ExtraWhitespace /\s\+$/
  map <leader>T  :%s/\s\s*$//g<cr>

" " User
"|------------------------------------------------------------------------------|

" linter
  let b:ale_fixers = {'javascript': ['prettier', 'eslint'], 'python': ['flake8', 'black']}
  let g:vim_jsx_pretty_colorful_config = 1

" ctrlp - <leader> t
  let g:ctrlp_map = '<leader>t'
  map <leader>b :CtrlPBuffer<cr>
  map <leader>r :CtrlPMRU<cr>
  set runtimepath^=~/.config/nvim/bundle/ctrlp.vim/autoload/ctrlp.vim
  let g:ctrlp_working_path_mode = 2
  let g:ctrlp_custom_ignore = '_site\|node_modules\|\.git$\|\.svn$|\.swp$|\.o$|'
  set wildignore+=*.o,*.obj,.git,*.swp,tmp,*.jsx.html,*.pyc
   let g:ctrlp_prompt_mappings = {
    \ 'PrtSelectMove("k")':   ['<c-u>', '<up>'],
    \ }

" nerdtree - <leader> e - I don't really use it, but I guess it could be
" helpful
  map <leader>e :NERDTreeToggle<CR>
  let NERDTreeHijackNetrw=1

" vim-commentary - <select_text> gc

" vim-fugitive - <leader> i
  map <leader>i :Gstatus<CR>
  map <leader>q :Gblame<CR>
  map <leader>gad :G add .<CR>
  map <leader>gco :G checkout -b"
  map <leader>gcm :G commit -m"
  map <leader>G :Gbrowse<CR>

" vim-indent-guides - <leader> ig

" vim-tbone
  map <leader>p :Tput<CR>
  map <leader>y :Tyank<CR>

" vim-test - <leader> n, <leader> r, <leader> l
  " map <Leader>n :TestNearest<CR>
  " map <Leader>r :TestFile<CR>
  " map <Leader>l :TestLast<CR>
  " let test#strategy = \"vimux"
  " let test#project_root = \""
  " let test#enabled_runners = ["ruby#rspec"]

" Vimux - <leader> c, <leader> z, <leader> x
" Vimux opens a small tmux pane and runs a command. Above, it's set to work
" with vim-test for specs.
  " nnoremap <leader>c :call VimuxPromptCommand()<CR>
  " nnoremap <leader>z :call VimuxZoomRunner()<CR>
  " nnoremap <leader>x :call VimuxCloseRunner()<CR>
  " let g:VimuxUseNearest = 0
  " let VimuxUseNearest = 0


" " Passive
"|------------------------------------------------------------------------|

" lightline
  let g:lightline = {
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'component_function': {
        \   'gitbranch': 'fugitive#head',
        \   'filename': 'LightlineFilename',
        \ },
        \ }
  function! LightlineFilename()
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let modified = &modified ? ' +' : ''
    return filename . modified
  endfunction

autocmd FileType python map <buffer> <F2> :call flake8#Flake8()<CR>

" vim.fzf
" Helpful Commands
" :Commits
" :Rg
set rtp+=~/.fzf
let g:fzf_preview_window = 'right:60%'
map <leader>r :Rg<CR>

"" vim-eunuch
" helpful commands:
" :SudoWrite
" :Move
" :Delete
" :Mkdir
" vim-endwise

" vim-gitgutter

" vim-lastplace

" vim-rails

" vim-test

" vimux

" yankstack

