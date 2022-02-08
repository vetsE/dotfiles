source ~/.config/nvim/base.vim

call plug#begin('~/.local/share/nvim/plugged')

" Ergonomy
Plug 'vetsE/vim-bepo'

" File manager
" Plug 'francoiscabrol/ranger.vim'
Plug 'kevinhwang91/rnvimr'

" Autoformat
Plug 'sbdchd/neoformat'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'ray-x/lsp_signature.nvim'
Plug 'p00f/clangd_extensions.nvim'

" Look
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/lsp-colors.nvim'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Comments
Plug 'numToStr/Comment.nvim'

" Git gutter signs
Plug 'lewis6991/gitsigns.nvim'

" Status line
Plug 'hoob3rt/lualine.nvim'

" Completion
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}

" Must have
Plug 'machakann/vim-highlightedyank'
Plug 'luukvbaal/stabilize.nvim'
Plug 'mbbill/undotree'
Plug 'machakann/vim-sandwich'
Plug 'mechatroner/rainbow_csv'
" Plug 'dhruvasagar/vim-table-mode'

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
Plug 'wuelnerdotexe/vim-enfocado'
Plug 'folke/lsp-colors.nvim'

" Doc
Plug 'danymat/neogen'

call plug#end()

lua << EOF
require('init')
EOF

source ~/.config/nvim/ergonomy.vim
source ~/.config/nvim/colorscheme.vim
source ~/.config/nvim/shortcuts.vim
source ~/.config/nvim/look.vim
