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
set tabstop=2
set softtabstop=2
set shiftwidth=2
" backspace
set backspace=indent,eol,start

" encoding
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
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

" Set map leader
let mapleader = ","
noremap \ ,

" paste
nnoremap <Leader>i :<C-u>set paste<Return>i
autocmd InsertLeave * set nopaste

" ----------------------------------------
" Window Setting
" window split option
set splitbelow
set splitright

" window width/height
set winwidth=20
set winheight=5

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
  if winwidth(0) < 20
    vertical resize 20
  endif
endfunction

function! s:good_height()
  if winheight(0) < 5
    vertical resize 5
  endif
endfunction

" ----------------------------------------
" Session
au VimLeave * mks! ~/.vim.session

" ----------------------------------------
" key mapping
nnoremap <Leader>u <ESC>:Unite -vertical -winwidth=40 outline<Return>
nnoremap <Leader>t <ESC>:NERDTreeToggle<Return>
nnoremap <Leader>l :<C-u>call append(expand('.'), '')<Return>j

" perltidy
noremap <Leader>pt <Esc>:%! perltidy<Return>
noremap <Leader>ptv <Esc>:'<,'>! perltidy<Return>

" ruby-align
noremap <Leader>ra <Esc>:%! ruby-align<Return>
noremap <Leader>rav <Esc>:'<,'>! ruby-align<Return>

" US keyboard
"nnoremap ; :
"nnoremap : ;

" ----------------------------------------
" use templates
autocmd BufNewFile *.pp      0r $HOME/.vim/template/puppet-module.txt
autocmd BufNewFile *.sh      0r $HOME/.vim/template/bash.sh
autocmd BufNewFile *.bash    0r $HOME/.vim/template/bash.sh
autocmd BufNewFile *.pl      0r $HOME/.vim/template/perl-script.pl
autocmd BufNewFile *.pm      0r $HOME/.vim/template/perl-module.pm
autocmd BufNewFile *.t       0r $HOME/.vim/template/perl-test.t
autocmd BufNewFile clam.spec 0r $HOME/.vim/template/clam.spec

" ----------------------------------------
" Go
set rtp^=$GOPATH/src/github.com/nsf/gocode/vim
command Gorun execute "!go run %"
au BufWritePre *.go Fmt

" ----------------------------------------
" NeoBundle
filetype off
if has('vim_starting')
  if &compatible
    set nocompatible " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Align'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'vim-jp/vim-go-extra'
NeoBundle 'google/vim-ft-go'
NeoBundle 'elzr/vim-json'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'hashivim/vim-terraform'
NeoBundleLazy 'mopp/layoutplugin.vim', { 'autoload' : { 'commands' : 'LayoutPlugin'} }

call neobundle#end()

" Reqiured:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" ----------------------------------------
" for plugins
set nocp

" for Align
let g:Align_xstrlen=3

" for Unite
let g:unite_split_rule = 'botright'

" for vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" for syntastic
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

" vim: expandtab tabstop=2 softtabstop=2 shiftwidth=2
