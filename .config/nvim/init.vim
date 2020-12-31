source ~/.config/nvim/base.vim

call plug#begin('~/.local/share/nvim/plugged')

" Ergonomy
Plug 'michamos/vim-bepo'
Plug 'kevinhwang91/rnvimr'
Plug 'voldikss/vim-floaterm'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-surround'

" Colorschemes
Plug 'vim-airline/vim-airline-themes'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'bluz71/vim-nightfly-guicolors'

" Look
Plug 'ryanoasis/vim-devicons'
Plug 'yggdroot/indentline'

" Lsp stuff
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()

lua << EOF
require('init')
EOF

source ~/.config/nvim/ergonomy.vim
source ~/.config/nvim/colorscheme.vim
source ~/.config/nvim/shortcuts.vim
source ~/.config/nvim/look.vim
