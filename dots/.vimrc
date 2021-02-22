set nocompatible
set timeoutlen=400
syntax on

"-- Key mappings --
let mapleader=','

"-- insert mode --
"" exit->normal
inoremap <Leader>, <Esc><left>
" yank->clipboard
inoremap <Leader>yy "*yy
inoremap <Leader>p <C-o><left><C-o>"*p

"-- normal mode --
" paste<-clipboard
nnoremap <Leader>p "*p
" yank->clipboard
nnoremap <Leader>yy "*yy
" cutline->clipboard
nnoremap <Leader>D "*D
nnoremap <C-p> :AgFiles<CR>
nnoremap <C-f> :AgInFiles<CR>
nnoremap tn :tabnext<CR>
nnoremap tp :tabprevious<CR>
nnoremap tN :tabnew<CR>
nnoremap tmn :tabmove +1<CR>
nnoremap tmp :tabmove -1<CR>
" open terminal across the bottom
nnoremap <C-a> :botright terminal ++rows=15<CR>

"-- visual mode --
" exit->normal
xnoremap <Leader>, <Esc>
" yank->clipboard
xnoremap <Leader>y "*y
" paste<-clipboard
xnoremap <Leader>p "*p
" cut->clipboard
xnoremap <Leader>d "*d
"xnoremap <S-l> $

"-- Visual help stuff --
set mouse=a
set lcs=tab:>-,eol:$,space:.
set nowrap
"" highlight all occourances of search found
set hlsearch
"set ruler"" This is set by Plugin: itchyny/lightline.vim
"set cursorcolumn ""Show column at cursors location
set cursorline ""Show row at cursors location
set colorcolumn=80
set laststatus=2 ""Shows full status bar at bottom
set noshowmode ""Removes mode from bottom status bar line
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

if !has('gui_running')
  set t_Co=256
endif

"-- File Extentions --
autocmd BufNewFile,BufRead *.env.* set syntax=sh

"-- Custom Functions --
function Mdflat ()
  :%s/\v\n  ([^-*])/ \1/g
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

call plug#end()

"-- Plugin Specific Configuration --
"--- Plugin: (lightline) ---
""Set colour theme, and status bar items
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'modified' ],
  \             [ 'absolutepath' ] ],
  \   'right': [ [ 'lineinfo', 'percent' ],
  \              [ 'linter', 'filetype' ] ],
  \ },
  \ 'component_function': {
  \   'gitbranch': 'gitbranch#name',
  \ },
  \ }

"--- Plugin: (seoul256) ---
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

"--- Plugin: (vim-javascript) ---
""Fix JSON syntax highlighting
let g:vim_json_conceal = 0

"--- Plugin: (ale) ---
let g:ale_linters = {
\   'javascript': ['standard', 'eslint'],
\}
let g:ale_fixers = {'javascript': ['standard']}
let g:ale_fix_on_save = 1
let g:ale_sign_column_always=1

" Plugin: (vim-markdown)
let g:vim_markdown_folding_disabled = 1

"--- Plugin: (NERDTree) ---
map <Leader>b :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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
let g:fzf_layout = {
 \ 'window': {
 \   'width': 0.8,
 \   'height': 0.6,
 \ },
 \ }
let g:fzf_buffers_jump = 1

command! -bang -nargs=? -complete=dir AgInFiles call fzf#vim#ag(<q-args>,
      \ fzf#vim#with_preview({
      \ 'options': '--delimiter : --nth 4..',
      \ 'dir': getcwd(),
      \ }), <bang>0)

command! -bang -nargs=? -complete=dir AgFiles call fzf#run(
      \ fzf#wrap('ag-files', fzf#vim#with_preview({
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
