set termguicolors     " Enable true colors support
let &t_ut=''
set background=dark

" let ayucolor="light"  " for light version of theme
let ayucolor="dark"   " for dark version of theme

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

" colorscheme OceanicNext
" colorscheme NeoSolarized
colorscheme onedark

" Statusline
" ----------
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" let g:airline_theme = 'ayudark'

" Highlights
" ----------
hi ALEErrorLine guifg=#dc322f guibg=#073642 gui=bold
