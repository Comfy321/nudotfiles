set nocompatible              " be iMproved, required
"This vimrc is meant for nvim use (it is symlinked to the nvim config so
"things may or may not be wierd if you use vim.

set number
set ruler
syntax on
let mapleader = " "

filetype indent on
set smartindent
"tabs
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

set clipboard=unnamed

" remove highlighting with leader + h
map <leader>h :noh<enter>
" Automatic closing of brackets.
autocmd Filetype c,cpp,h,java,js inoremap {<enter> {<enter>}<C-o>O
"quikk save
map <leader><leader> :w<enter>

" PLUGINS
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'reedes/vim-pencil'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mattn/emmet-vim'
Plugin 'neovimhaskell/haskell-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'roxma/nvim-yarp'
Plugin 'junegunn/goyo.vim'
Plugin 'scrooloose/syntastic'
Plugin 'ycm-core/youcompleteme'

" Plugin 'alx741/vim-stylishask'

call vundle#end()            " required
filetype plugin indent on    " required

let laststatus = 0
"NERDTree
map <C-f> :NERDTreeToggle
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"ctrlp settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = '\v\.(class|git)$'

"goyo
map <leader>g :Goyo<enter>

"haskell vim 
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

let g:haskell_indent_if = 4
let g:haskell_indent_case = 4
let g:haskell_indent_let = 4
let g:haskell_indent_where = 4
let g:haskell_indent_before_where = 4
let g:haskell_indent_after_bare_where = 4
let g:haskell_indent_do = 4
let g:haskell_indent_in = 4
let g:haskell_indent_guard = 4
let g:haskell_indent_case_alternative = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
