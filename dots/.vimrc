set encoding=UTF-8
" set nocompatible
set timeoutlen=200
syntax on

"-- Key mappings --
let mapleader=','

" save file
nnoremap <leader>s :w<CR>

" exit->normal
inoremap <leader>, <esc><right>
xnoremap <leader>, <esc><right>

" yank to system clipboard
inoremap <leader>yy "*yy
nnoremap <leader>yy "*yy

" cut line to system clipboard
nnoremap <leader>D "*D

" paste from system clipboard
inoremap <leader>p <c-o>"*p
nnoremap <leader>p "*p

" yank to register
xnoremap <leader>y "*y
" paste from register
xnoremap <leader>p "*p
" cut to register
xnoremap <leader>d "*d

" move lines up and down
" inoremap <s-j> <Esc>:m .+1<CR>==gi
" inoremap <s-k> <Esc>:m .-2<CR>==gi
nnoremap <s-j> :m .+1<CR>==
nnoremap <s-K> :m .-2<CR>==
vnoremap <s-j> :m '>+1<CR>gv=gv
vnoremap <s-k> :m '<-2<CR>gv=gv

" move screen up and down
nnoremap <c-j> <c-e>
nnoremap <c-k> <c-y>

" search for files
nnoremap <c-p> :AgFiles<CR>
nnoremap <c-f> :AgInFiles<CR>

" manage tabs
nnoremap tN :tabnew<CR>
nnoremap tn :tabnext<CR>
nnoremap tp :tabprevious<CR>
nnoremap tmn :tabmove +1<CR>
nnoremap tmp :tabmove -1<CR>

" manage windows
nnoremap <leader>wl <c-w><right>
nnoremap <leader>wh <c-w><left>
nnoremap <leader>wj <c-w><down>
nnoremap <leader>wk <c-w><up>
nnoremap <leader>wn :rightb vnew<CR>
nnoremap <leader>wN :rightb new<CR>

"" move window far right
nnoremap <leader>wL <c-w>L
"" move window far left
nnoremap <leader>wH <c-w>H
"" move window very bottom
nnoremap <leader>wJ <c-w>J
"" move window very top
nnoremap <leader>wK <c-w>K

" open terminal across the bottom
nnoremap <c-a> :botright terminal ++rows=15<CR>

" search word under cursor
nnoremap <silent> # :let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>

"-- Visual help stuff --
set mouse=a
set lcs=tab:>-,eol:$,space:.
set nowrap
set hlsearch        " highlight all occourances of search found
"set ruler          " This is set by Plugin: itchyny/lightline.vim
"set cursorcolumn   " Show column at cursors location
set cursorline      " Show row at cursors location
set colorcolumn=80
set laststatus=2    " Shows full status bar at bottom
set noshowmode      " Removes mode from bottom status bar line
set foldmethod=syntax
set foldcolumn=1
let javaScript_fold=1
set foldlevelstart=99
set completeopt+=menuone,noinsert

"-- Formatting --
set tabstop=2
set shiftwidth=2
set softtabstop=2 ""Allow deletion of whole tabs
set expandtab
set autoindent
set number
set backspace=indent,eol,start
"" trim trailing whitespace on :w
autocmd BufWritePre * %s/\s\+$//e
command! -nargs=* Wrap set wrap linebreak nolist

if !has('gui_running')
  set t_Co=256
endif

"-- File Extentions --
autocmd BufNewFile,BufRead *.env.* set syntax=sh

"-- Custom Functions --
function Mdflat ()
  :%s/\v\n  ([^-*])/ \1/g
endfunction

function IsTreeLast ()
  "- only one window in current buffer
  "- window is managed by NERDTree
  "- window is a TabTree
  if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree())
    return 1
  endif
endfunction

function ShouldCloseNERDTree ()
  "- is only NERDTree
  "- there are more tabs
  if (IsTreeLast() && tabpagenr('$') > 1)
    return 1
  endif
endfunction

function IsGitMsg()
  if (expand('%:t') == "COMMIT_EDITMSG") || (expand('%:t') == "git-rebase-todo")
    return 1
  endif
endfunction

" Check if vim-plug is installed; install if not
if empty(glob('~/.vim/autoload/plug.vim'))
  echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"-- Initialize vim-plug --
call plug#begin()
Plug 'junegunn/seoul256.vim'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

"-- Functionality --
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
Plug 'preservim/nerdtree'
" Plug 'ryanoasis/vim-devicons'
" Plug 'vwxyutarooo/nerdtree-devicons-syntax'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dense-analysis/ale'
Plug 'lifepillar/vim-mucomplete'
Plug 'raimondi/delimitmate'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"-- Syntax Highlighting --
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'ekalinin/Dockerfile.vim'
Plug 'junegunn/limelight.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'hashivim/vim-terraform'

call plug#end()

"-- PLUGIN SPECIFIC CONFIGURATION --
"--- Plugin: (lightline) ---
" Set colour theme, and status bar items
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'modified' ],
  \             [ 'filename' ] ],
  \   'right': [ [ 'lineinfo', 'percent' ],
  \              [ 'linter', 'filetype' ] ],
  \ },
  \ 'component_function': {
  \   'gitbranch': 'gitbranch#name',
  \ },
  \ }

"--- Plugin: (seoul256) ---
" Color Theme Settings
" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
" seoul256 (light):
"   Range:   252 (darkest) ~ 256 (lightest)
"   Default: 253
let g:seoul256_light_background = 253
let g:seoul256_background = 234
color seoul256

"--- Plugin: (vim-javascript) ---
" Fix JSON syntax highlighting
let g:vim_json_conceal = 0

"--- Plugin: (ale) ---
let g:ale_linters = {
\   'javascript': ['standard', 'eslint'],
\}
let g:ale_fixers = {'javascript': ['standard']}
let g:ale_fix_on_save = 1
let g:ale_sign_column_always=1

"--- Plugin: (vim-markdown)
let g:vim_markdown_folding_disabled = 1

"--- Plugin: (NERDTree) ---
map <leader>b :NERDTreeToggle<CR>
map <leader>E :NERDTreeFocus<CR>
let NERDTreeShowHidden=1
" open NERDTree when vim starts; move cursor to main window
" autocmd VimEnter * if !(IsGitMsg()) | NERDTree | wincmd p

" Exit Vim if NERDTree is the only window left.
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

" Close the existing NERDTree if on windows left; not main tab
autocmd BufEnter * if (IsTreeLast() && ShouldCloseNERDTree()) |  quit | endif

"--- Plugin: (NERDTreeGitStatus) ---
let g:NERDTreeGitStatusIndicatorMapCustom = {
 \ 'Modified'  :'✹',
 \ 'Staged'    :'✚',
 \ 'Untracked' :'✭',
 \ 'Renamed'   :'➜',
 \ 'Unmerged'  :'═',
 \ 'Deleted'   :'✖',
 \ 'Dirty'     :'✗',
 \ 'Ignored'   :'☒',
 \ 'Clean'     :'✔︎',
 \ 'Unknown'   :'?',
 \ }

"--- Plugin: (font-icons) ---
let g:webdevicons_enable = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let s:colors = {
  \ 'brown'       : "905532",
  \ 'aqua'        : "3AFFDB",
  \ 'blue'        : "689FB6",
  \ 'darkBlue'    : "44788E",
  \ 'purple'      : "834F79",
  \ 'lightPurple' : "834F79",
  \ 'red'         : "AE403F",
  \ 'beige'       : "F5C06F",
  \ 'yellow'      : "F09F17",
  \ 'orange'      : "D4843E",
  \ 'darkOrange'  : "F16529",
  \ 'pink'        : "CB6F6F",
  \ 'salmon'      : "EE6E73",
  \ 'green'       : "8FAA54",
  \ 'lightGreen'  : "31B53E",
  \ 'white'       : "FFFFFF"
\ }

"--- Plugin: (mucomplete) ---
let g:mucomplete#enable_auto_at_startup = 1
set shortmess+=c
set belloff+=ctrlg

"--- Plugin: (delimitMate) ---
let g:delimitMate_expand_cr = 1

"--- Plugin: (limelight) ---
"autocmd VimEnter * Limelight
let g:limelight_default_coefficient = 0.3
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

"--- Plugin: (fzf) ---
" let g:fzf_layout = {
"  \ 'window': {
"  \   'width': 0.8,
"  \   'height': 0.6,
"  \ },
"  \ }
let g:fzf_preview_window = ['up:50%']
let g:fzf_buffers_jump = 1

command! -bang -nargs=? -complete=dir AgInFiles call fzf#vim#ag(<q-args>,
      \ fzf#vim#with_preview({
      \ 'options': '--delimiter : --nth 4..',
      \ 'dir': getcwd(),
      \ }), <bang>0)

" command! -bang -nargs=? -complete=dir AgInFiles call fzf#run(
"       \ fzf#wrap('ag-in-files', fzf#vim#with_preview({
"       \ 'source': 'ag --color --hidden',
"       \ 'options': '--ansi --delimiter : --nth 4..',
"       \ 'dir': getcwd(),
"       \ }), <bang>0)
"       \ )

command! -bang -nargs=? -complete=dir AgFiles call fzf#run(
      \ fzf#wrap(fzf#vim#with_preview({
      \ 'source': 'ag --files-with-matches --color --hidden',
      \ 'options': '--ansi',
      \ 'dir': getcwd(),
      \ }), <bang>0)
      \ )

"-- Highligh Color --
"" highlight color must be set down here, after other syntax colors have been
"" set. Otherwise the below commands would just be overridden.
highlight ColorColumn ctermbg=88
"highlight Comment ctermfg=green ""Change comment lines to a lime green
