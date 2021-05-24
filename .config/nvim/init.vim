source ~/.config/nvim/base.vim

call plug#begin('~/.local/share/nvim/plugged')

" Ergonomy
Plug 'michamos/vim-bepo'
Plug 'kevinhwang91/rnvimr'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-surround'

" Colorschemes
Plug 'vim-airline/vim-airline-themes'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'mhartington/oceanic-next'
Plug 'ChristianChiarulli/nvcode-color-schemes.vim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc'

" Look
Plug 'ryanoasis/vim-devicons'
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/lsp-colors.nvim'

" Autoformat
" Plug 'sbdchd/neoformat'
Plug 'pappasam/vim-filetype-formatter'

" Autocompletion
Plug 'hrsh7th/nvim-compe'
" Plug 'nvim-lua/completion-nvim'
" Plug 'steelsojka/completion-buffers'
" Plug 'nvim-treesitter/completion-treesitter'

" Lsp stuff
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'folke/trouble.nvim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mlaursen/vim-react-snippets'

" React.js
Plug 'yuezk/vim-js'
Plug 'mattn/emmet-vim'
Plug 'MaxMEllon/vim-jsx-pretty'

" Tex
Plug 'lervag/vimtex'

call plug#end()

lua << EOF
require('init')
EOF

source ~/.config/nvim/ergonomy.vim
source ~/.config/nvim/colorscheme.vim
source ~/.config/nvim/shortcuts.vim
source ~/.config/nvim/look.vim
