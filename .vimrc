execute pathogen#infect()
syntax on
set clipboard=unnamed
set nocompatible
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab
set number
imap <silent> jj <Esc>:update<Enter>
imap <silent> ;; <Esc>

"" custom mappings
" yes, my leader key is spacebar. Try it.
let mapleader=" "

" ctrlp options
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<leader>t'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = '_site\|node_modules\|\.git$\|\.svn$|\.swp$|\.o$|'
set wildignore+=*.o,*.obj,.git,*.swp,tmp
map <leader>b :CtrlPBuffer<cr>

"" remove trailing whitespaces
map <leader>T  :%s/\s\s*$//g<cr>

" Hitting the spacebar is easier than hitting colon.
map <leader>w <Esc>:w
map <leader>q <Esc>:q

" Whitespace
:highlight ExtraWhitespace ctermbg=darkblue guibg=darkblue
:match ExtraWhitespace /\s\+$/

" Wrapped text is nightmare fuel.
set nowrap

" When you're at the beginning of a line, backspace will move to the end of
" the line above it instead of the default.
set backspace=indent,eol,start
set laststatus=2
set ttyfast

" This is a temporary disabling of the arrow keys, because many vim people
" will tell you to use HJKL instead. While I appreciate that in theory, I
" think it's a load of BS... But I wanted to force myself into HJKL life for a
" few months before I spoke on the subject. We're on month two and I'm
" burning this with fire soon:
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" RSpec bindings
let g:rspec_command = "VtrSendCommandToRunner! rspec {spec}"
map <Leader>r :call RunCurrentSpecFile()<CR>
map <Leader>n :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" This are mainly used for RSpec and debugging, though their functionality could be
" multi-purpose
map <Leader>ap :VtrAttachToPane()<CR>
map <Leader>s :VtrSendLinesToRunner<CR>
map <Leader>z :VtrFocusRunner()<CR>
map <Leader>or :VtrOpenRunner()<CR>
map <leader>pry :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': `rails c`}<cr>

" Automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>
