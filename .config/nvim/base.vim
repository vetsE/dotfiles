nnoremap <SPACE> <Nop>
let mapleader="\<Space>"
set mouse=a
set nocompatible  " Vim no vi.
filetype off      " This makes Vundle happy.
filetype plugin indent on
set hidden
set lazyredraw                 " Redraw the screen when needed.
set showmatch                  " Show the matching bracket.
set mat=2                      " How long to show the matching bracket.
set ffs=unix,dos,mac           " EOF that are tried on files.
set lbr                        " Just wrap already.
set list                       " Display annoying non-printable characters.
set listchars=tab:>>,trail:_,nbsp:¤,extends:↙,precedes:↗   " Those ones.
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=white guibg=#cc0000
set cursorline                 " Display the current cursor line.
set number
set shell=/usr/bin/zsh

" Indenting stuff
set tabstop=4                  " Number of spaces that a <Tab> counts for.
set shiftwidth=4               " Number of spaces that a shift insert.
set expandtab                  " Use the appropriate number of spaces to insert a <Tab>.
set autoindent                 " Copy the indentation of the last line.
set smartindent                " Smarter indenting.
set smarttab                   " Smarter tabbing.

" Editing stuff
set encoding=utf-8
set fileencoding=utf-8
set signcolumn=yes
set backspace=indent,eol,start " All backspace in insert mode.
set history=1000               " 50 isn't enough!
set showcmd                    " Show partial commands.
set updatetime=300
syntax on
set showtabline=2
