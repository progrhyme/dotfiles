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

colorscheme elflord

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

" NOTE:
"  Additional plugin-related key mappings are defined in plugins.toml loaded
"  by dein later in this .vimrc

" ----------------------------------------
" use templates
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
" dein.vim / START
if &compatible
  set nocompatible " Be iMproved
endif

let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:config_dir = expand('~/.dotfiles/vim')

" Required:
execute 'set runtimepath^=' . s:dein_repo_dir

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(s:config_dir . '/dein-plugins.toml', {'lazy': 0})
  call dein#load_toml(s:config_dir . '/dein-lazy-plugins.toml', {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" dein.vim / END
" ----------------------------------------

highlight clear StatusLine
highlight StatusLine ctermfg=black ctermbg=blue

" vim: expandtab tabstop=2 softtabstop=2 shiftwidth=2
