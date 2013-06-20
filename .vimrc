set autoindent
" show line number
set number
" show tabs, eol, etc.
set list
" fill white spaces instead of tab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" syntax
syntax on
" modeline
set modeline
set modelines=3
" folding
set foldmethod=indent
set foldcolumn=3
set foldlevel=2

" ----------------------------------------
" Status Line
set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P
" show statusline always
set laststatus=2
" color
highlight StatusLine term=bold cterm=bold ctermfg=black ctermbg=blue

" ----------------------------------------
" Window Setting
" window split option
set splitbelow
set splitright

" window width
set winwidth=100

" good width setting
nnoremap <C-w>h <C-w>h:call <SID>good_width()<Cr>
nnoremap <C-w>l <C-w>l:call <SID>good_width()<Cr>
nnoremap <C-w>H <C-w>H:call <SID>good_width()<Cr>
nnoremap <C-w>L <C-w>L:call <SID>good_width()<Cr>
function! s:good_width()
  if winwidth(0) < 84
    vertical resize 84
  endif
endfunction

" ----------------------------------------
" key mapping
noremap ,u <ESC>:Unite -vertical -winwidth=40 outline<Return>

" ----------------------------------------
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

" ----------------------------------------
" for plugins
set nocp
filetype plugin on

" for Align
let g:Align_xstrlen=3

" for Unite
let g:unite_split_rule = 'botright'

