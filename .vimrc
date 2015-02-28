" ----------------------------------------
" Basic Editor Settings

set autoindent
" show line number
set number
" show tabs, eol, etc.
set list
set listchars=tab:>-,extends:<,trail:-,eol:$
" fill white spaces instead of tab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" backspace
set backspace=indent,eol,start

" encoding
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac

" ----------------------------------------
" Additional Editor Settings

" syntax
syntax on
" modeline
set modeline
set modelines=3
" folding
set foldmethod=indent
set foldcolumn=3
set foldlevel=10

" Status Line
set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P
" show statusline always
set laststatus=2
" color
highlight StatusLine term=bold cterm=bold ctermfg=black ctermbg=blue

set hlsearch

" paste
nnoremap ,i :<C-u>set paste<Return>i
autocmd InsertLeave * set nopaste

" ----------------------------------------
" Window Setting
" window split option
set splitbelow
set splitright

" window width/height
set winwidth=80
set winheight=25

" good width/height setting
nnoremap <C-w>h <C-w>h:call <SID>good_width()<Cr>
nnoremap <C-w>l <C-w>l:call <SID>good_width()<Cr>
nnoremap <C-w>H <C-w>H:call <SID>good_width()<Cr>
nnoremap <C-w>L <C-w>L:call <SID>good_width()<Cr>
nnoremap <C-w>k <C-w>k:call <SID>good_height()<Cr>
nnoremap <C-w>j <C-w>j:call <SID>good_height()<Cr>
nnoremap <C-w>K <C-w>K:call <SID>good_height()<Cr>
nnoremap <C-w>J <C-w>J:call <SID>good_height()<Cr>

function! s:good_width()
  if winwidth(0) < 80
    vertical resize 80
  endif
endfunction

function! s:good_height()
  if winheight(0) < 25
    vertical resize 25
  endif
endfunction

" ----------------------------------------
" Session
au VimLeave * mks! ~/.vim.session

" ----------------------------------------
" key mapping
nnoremap ,u <ESC>:Unite -vertical -winwidth=40 outline<Return>
nnoremap ,t <ESC>:NERDTreeToggle<Return>
nnoremap ,l :<C-u>call append(expand('.'), '')<Return>j

" perltidy
noremap ,pt <Esc>:%! perltidy<Return>
noremap ,ptv <Esc>:'<,'>! perltidy<Return>

" US keyboard
nnoremap ; :
nnoremap : ;

" ----------------------------------------
" use templates
autocmd BufNewFile *.pp 0r $HOME/.vim/template/puppet-module.txt

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
NeoBundle 'slim-template/vim-slim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'vim-jp/vim-go-extra'
NeoBundle 'google/vim-ft-go'

filetype plugin indent on

" ----------------------------------------
" for plugins
set nocp

" for Align
let g:Align_xstrlen=3

" for Unite
let g:unite_split_rule = 'botright'

" vim: expandtab tabstop=2 softtabstop=2 shiftwidth=2
