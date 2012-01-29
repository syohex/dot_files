syntax on
set ignorecase
set notitle
set showmatch
set noautoindent
set nobackup
filetype on
filetype indent on
filetype plugin on

set visualbell
set vb t_vb=

set tabstop=8
set expandtab

set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

syntax on
set term=xterm-256color
set t_Co=256
