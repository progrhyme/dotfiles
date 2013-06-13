set autoindent
" show line number
set number
" show tabs, eol, etc.
set list
" fill white spaces instead of tab
set expandtab
set tabstop=4
" show statusline always
set laststatus=2
" for plugins
set nocp
filetype plugin on
" for Align
let g:Align_xstrlen=3

" NeoBundle
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundle 'Shougo/unite.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'Align'

filetype plugin on
filetype indent on
