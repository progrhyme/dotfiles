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

" US keyboard
"nnoremap ; :
"nnoremap : ;

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
" vim-plug / START
call plug#begin()
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'leafcage/yankround.vim'
Plug 'vim-scripts/Align'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-endwise'
Plug 'junegunn/vim-easy-align'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'
Plug 'ervandew/supertab'
Plug 'cespare/vim-toml'
call plug#end()

" unite.vim
let g:unite_split_rule = 'botright'

" unite-outline
nnoremap <Leader>u <ESC>:Unite -vertical -winwidth=40 outline<Return>

" yankround.vim
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-k> <Plug>(yankround-prev)
nmap <C-j> <Plug>(yankround-next)
nnoremap <Leader>y <ESC>:Unite yankround<Return>

" Align
let g:Align_xstrlen=3

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" ctrlp.vim
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_user_command =
  \ ['.git', 'cd %s && git ls-files -co --exclude-standard']
nnoremap <Leader>/ <ESC>:CtrlPLine<Return>

" vim-operator-replace
nmap <Space> <Plug>(operator-replace)

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" vim-plug / END
" ----------------------------------------

highlight clear StatusLine
highlight StatusLine ctermfg=black ctermbg=blue

" vim: expandtab tabstop=2 softtabstop=2 shiftwidth=2
