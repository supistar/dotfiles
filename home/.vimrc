" NeoBundle
set nocompatible
filetype plugin indent off

if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'alpaca-tc/alpaca_powertabline'
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
NeoBundle 'Lokaltog/powerline-fontpatcher'
NeoBundle 'Flake8-vim'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'hynek/vim-python-pep8-indent'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'scrooloose/syntastic'

call neobundle#end()
filetype plugin indent on
syntax on

" Common settings
set cinkeys-=0#
set cindent
set autoindent
set noswapfile
set nobackup
set undodir=~/.vim/undo
set browsedir=buffer
set clipboard=unnamed
set expandtab
set incsearch

set list
set listchars=eol:$,tab:>\ ,extends:<

set number
set shiftwidth=4
set showmatch
set nosmartcase
set smartindent
set smarttab
set tabstop=4
set whichwrap=b,s,h,l,<,>,[,]

set enc=utf-8
set fenc=utf-8
set fencs=utf-8,iso-2022-jp,euc-jp,cp932

if &term =~ "xterm-debian" || &term =~ "xterm-xfree86" || &term =~ "xterm-256color"
    set t_Co=16
    set t_Sf=^[[3%dm
    set t_Sb=^[[4%dm
elseif &term =~ "xterm-color"
    set t_Co=8
    set t_Sf=^[[3%dm
    set t_Sb=^[[4%dm
endif

set cursorline
augroup cch
autocmd! cch
autocmd WinLeave * set nocursorline
autocmd WinEnter,BufRead * set cursorline
augroup END

:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

nmap <ESC><ESC> :nohlsearch<CR><ESC>

" Powerline
set laststatus=2
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'compatible'
set noshowmode

" Python
let g:PyFlakeOnWrite = 1
let g:PyFlakeCheckers = 'pep8,mccabe,pyflakes'
let g:PyFlakeDefaultComplexity=12
