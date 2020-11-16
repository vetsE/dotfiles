let mapleader=","
call plug#begin('~/.local/share/nvim/plugged')

" I'm not a noob.
Plug 'michamos/vim-bepo'

" Status line and co.
" Plug 'kyazdani42/nvim-web-devicons'
" Plug 'Akin909/nvim-bufferline.lua'
Plug 'itchyny/lightline.vim'
Plug 'taohexxx/lightline-buffer'
" Plug 'josa42/vim-lightline-coc'
" Plug 'liuchengxu/eleline.vim'
" Plug 'vim-airline/vim-airline'
" Plug 'ap/vim-buftabline'
" Plug 'sainnhe/edge'
Plug 'romgrk/nvim-treesitter-context'

" Comments
Plug 'tpope/vim-commentary'



" File explorer
" Plug 'francoiscabrol/ranger.vim'
Plug 'kevinhwang91/rnvimr'
Plug 'rbgrouleff/bclose.vim'

" Theme
Plug 'iCyMind/NeoSolarized'
Plug 'ryanoasis/vim-devicons'
Plug 'haishanh/night-owl.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ayu-theme/ayu-vim'
Plug 'romainl/Apprentice'
Plug 'morhetz/gruvbox'
Plug 'Iron-E/nvim-highlite'
Plug 'mhartington/oceanic-next'

" Look and feel
Plug 'yggdroot/indentline'
Plug 'mhinz/vim-signify'

" Tagbar
" Plug 'liuchengxu/vista.vim'
Plug 'majutsushi/tagbar'

" Terminal
Plug 'voldikss/vim-floaterm'

" Misc
" Plug 'tpope/vim-surround'
" Plug 'tpope/vim-repeat'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-sensible'
" Plug 'dense-analysis/ale'
Plug 'junegunn/goyo.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" lsp & co
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'sbdchd/neoformat'
Plug 'nvim-lua/completion-nvim'

" Completion
Plug 'honza/vim-snippets'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/deoplete-lsp'

" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-path'
" Plug 'ncm2/float-preview.nvim'
" Plug 'ncm2/ncm2-jedi'
" Plug 'ncm2/ncm2-ultisnips'

" Plug 'lifepillar/vim-mucomplete'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Syntax
Plug 'sheerun/vim-polyglot'

" Python
" Plug 'Guzzii/python-syntax'
" Plug 'tmhedberg/SimpylFold'
" Plug 'kalekundert/vim-coiled-snake'
Plug 'fisadev/vim-isort'

" tex

" html
Plug 'mattn/emmet-vim'

" vue
Plug 'posva/vim-vue'

" md
Plug 'gabrielelana/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" animation
" Plug 'camspiers/animate.vim'
" Plug 'camspiers/lens.vim'

" codi
" Plug 'metakirby5/codi.vim'

" alloy
" Plug 'lorin/vim-alloy'

" tempus colors
Plug 'https://gitlab.com/protesilaos/tempus-themes-vim.git'

" spelling
Plug 'dpelle/vim-LanguageTool'

" motions
Plug 'easymotion/vim-easymotion'

"latex
" Plug 'lervag/vimtex'

call plug#end()

source ~/.config/nvim/base.vim
source ~/.config/nvim/theme.vim
source ~/.config/nvim/file_explorer.vim
source ~/.config/nvim/shortcuts.vim
source ~/.config/nvim/tagbar.vim
source ~/.config/nvim/statusline.vim
source ~/.config/nvim/lookandfeel.vim
source ~/.config/nvim/linting.vim
source ~/.config/nvim/python.vim
source ~/.config/nvim/html.vim
source ~/.config/nvim/completion.vim
source ~/.config/nvim/codi.vim
source ~/.config/nvim/latex.vim

