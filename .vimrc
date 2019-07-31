" Note, I use Neovim and this configuration is stored in
" ~/config/nvim/init.vim
execute pathogen#infect()
""" Quick Reference/Table of Contents
"""
"" User
"--------------------------------
" ctrlp - <leader> t
" gundo - <leader> u
" nerdtree - <leader> e
" vim-commentary - <select_text> gc
" vim-fugitive - <leader> i
" vim-indent-guides - <leader> ig
" vim-multiple-cursors - <C-n>
" vim-yankstack - <leader> p/P *
"
" " Passive
" -------------------------------
" YouCompleteMe - tab
" lightline
" nerdtree-git
" vim-endwise
" vim-gitgutter
" vim-lastplace
" vim-rails
" vim-test
" vimux

" configurations
  syntax on
  set nocompatible
  set clipboard=unnamed " use system clipboard for yanks
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

" mappings
" typing 'jj' while in insert mode saves your file and enters normal mode
  imap <silent> jj <Esc>:update<Enter>
  let mapleader=" "

" whitespace
  :highlight ExtraWhitespace ctermbg=darkblue guibg=darkblue
  :match ExtraWhitespace /\s\+$/
  map <leader>w  :%s/\s\s*$//g<cr>

" " User
"|------------------------------------------------------------------------------|

" ctrlp - <leader> t
  let g:ctrlp_map = '<leader>t'
  map <leader>b :CtrlPBuffer<cr>
  set runtimepath^=~/.config/nvim/bundle/ctrlp.vim/autoload/ctrlp.vim
  let g:ctrlp_working_path_mode = 2
  let g:ctrlp_custom_ignore = '_site\|node_modules\|\.git$\|\.svn$|\.swp$|\.o$|'
  set wildignore+=*.o,*.obj,.git,*.swp,tmp

" gundo - <leader> u
  map <leader>u :GundoToggle<CR>

" nerdtree - <leader> e - I don't really use it, but I guess it could be
" helpful
  map <leader>e :NERDTreeToggle<CR>

" vim-commentary - <select_text> gc

" vim-fugitive - <leader> i
  map <leader>i :Gstatus<CR>

" vim-indent-guides - <leader> ig

" vim-multiple-cursors - <C-n>
" sublime-like edit multiple lines

" vim-test - <leader> n, <leader> r, <leader> l
  map <Leader>n :TestNearest<CR>
  map <Leader>r :TestFile<CR>
  map <Leader>l :TestLast<CR>
  let test#strategy = "vimux"
  let test#project_root = "~/Documents/dicksonone"
  let test#enabled_runners = ["ruby#rspec"]

" Vimux - <leader> c, <leader> z, <leader> x
" Vimux opens a small tmux pane and runs a command. Above, it's set to work
" with vim-test for specs.
  nnoremap <leader>c :call VimuxPromptCommand()<CR>
  nnoremap <leader>z :call VimuxZoomRunner()<CR>
  nnoremap <leader>x :call VimuxCloseRunner()<CR>
  let g:VimuxUseNearest = 0
  let VimuxUseNearest = 0


" " Passive
"|------------------------------------------------------------------------|

" YouCompleteMe - tab

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

" nerdtree-git

" vim-endwise

" vim-gitgutter

" vim-lastplace

" vim-rails

" vim-test

" vimux

" yankstack

