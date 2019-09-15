" syntax highlighting (default?)
syntax on
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set number
set backspace=indent,eol,start

" set hlsearch
" set ruler
" highlight Comment ctermfg=green

set laststatus=2
set noshowmode

if !has('gui_running')
  set t_Co=256
endif

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'itchyny/lightline.vim'
call plug#end()

let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'letf': [ [ 'mode', 'paste' ],
  \             [ 'readonly', 'filename', 'modified' ] ]
  \ },
  \ }
