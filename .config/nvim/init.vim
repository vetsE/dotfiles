source ~/.config/nvim/base.vim

call plug#begin('~/.local/share/nvim/plugged')

" Ergonomy
Plug 'vetsE/vim-bepo'
" Plug 'kevinhwang91/rnvimr'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'tpope/vim-commentary'
Plug 'mhinz/vim-signify'
Plug 'nvim-lua/plenary.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'machakann/vim-sandwich'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'machakann/vim-highlightedyank'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'romgrk/barbar.nvim'

" Colorschemes
" Plug 'vim-airline/vim-airline-themes'
" Plug 'rafi/awesome-vim-colorschemes'
" Plug 'bluz71/vim-nightfly-guicolors'
" Plug 'mhartington/oceanic-next'
" Plug 'ChristianChiarulli/nvcode-color-schemes.vim'
" Plug 'bluz71/vim-nightfly-guicolors'
" Plug 'xolox/vim-colorscheme-switcher'
" Plug 'xolox/vim-misc'
" Plug 'eddyekofo94/gruvbox-flat.nvim'
" Plug 'shaunsingh/moonlight.nvim'
Plug 'shaunsingh/nord.nvim'
Plug 'ishan9299/nvim-solarized-lua'
Plug 'marko-cerovac/material.nvim'
Plug 'mhartington/oceanic-next'
Plug 'folke/tokyonight.nvim'
Plug 'cocopon/iceberg.vim'

" Look
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/lsp-colors.nvim'
" Plug 'akinsho/nvim-bufferline.lua'

" Autoformat
Plug 'sbdchd/neoformat'
" Plug 'dhruvasagar/vim-table-mode'

" Autocompletion
Plug 'hrsh7th/nvim-compe'
Plug 'rstacruz/vim-closer'

" Lsp stuff
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'folke/trouble.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'nvim-lua/lsp-status.nvim'

" Snippets
" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mlaursen/vim-react-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'

" React.js
Plug 'yuezk/vim-js'
Plug 'mattn/emmet-vim'
Plug 'MaxMEllon/vim-jsx-pretty'

" Tex
" Plug 'lervag/vimtex'

call plug#end()

lua << EOF
require('init')
EOF

source ~/.config/nvim/ergonomy.vim
source ~/.config/nvim/colorscheme.vim
source ~/.config/nvim/shortcuts.vim
source ~/.config/nvim/look.vim
