set nocompatible
syntax on

" Visual help stuff
set mouse=a
set lcs=tab:>-,eol:$
set hlsearch ""highlight all occourances of search found
" set ruler ""This is set by Plugin: itchyny/lightline.vim
" highlight Comment ctermfg=green ""Change comment lines to a lime green
" set cursorcolumn ""Show column at cursors location
set cursorline ""Show row at cursors location
set laststatus=2 ""Shows full status bar at bottom
set noshowmode ""Removes mode from bottom status bar line

" Formatting
set tabstop=2
set shiftwidth=2
set softtabstop=2 ""Allow deletion of whole tabs
set expandtab
set autoindent
set number
set backspace=indent,eol,start

if !has('gui_running')
  set t_Co=256
endif

" Check if vim-plug is installed; install if not
if empty(glob('~/.vim/autoload/plug.vim'))
  echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Initialize vim-plug
call plug#begin()
Plug 'junegunn/seoul256.vim'
Plug 'itchyny/lightline.vim'

" Functionality
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree'

" Syntax Highlighting
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'ekalinin/Dockerfile.vim'

call plug#end()

" Plugin Specific Configuration
" Plugin: (lightline)
""Set colour theme, and status bar items
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'readonly', 'filename', 'modified' ] ]
  \ },
  \ }

" Plugin: (seoul256)
""Color Theme Settings
" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
" seoul256 (light):
"   Range:   252 (darkest) ~ 256 (lightest)
"   Default: 253
let g:seoul256_light_background = 253
let g:seoul256_background = 234
color seoul256

" Plugin: (vim-javascript)
""Fix JSON syntax highlighting
let g:vim_json_conceal = 0
