set termguicolors     " Enable true colors support

let &t_ut=''
set background=dark

" let ayucolor="light"  " for light version of theme
" let ayucolor="dark"   " for dark version of theme

syntax on
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

colorscheme OceanicNext
" colorscheme NeoSolarized
" colorscheme tempus_summer
"
" set background=dark
" colorscheme NeoSolarized
" let &t_ut=''
let g:neosolarized_contrast = "high"
let g:neosolarized_visibility = "high"
let g:neosolarized_bold = 1
let g:neosolarized_underline = 1
let g:neosolarized_italic = 1


" colorscheme night-owl
" " To enable the lightline theme
" let g:lightline = { 'colorscheme': 'nightowl' }

hi CocErrorLine guibg=#600000
