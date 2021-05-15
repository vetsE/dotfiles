set termguicolors     " Enable true colors support
let &t_ut=''
set background=dark

" let ayucolor="light"  " for light version of theme
let ayucolor="dark"   " for dark version of theme

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

" colorscheme lunar
colorscheme solarized8_high
" colorscheme snazzy
" colorscheme NeoSolarized
" colorscheme nightfly

" Statusline
" ----------
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" let g:airline_theme = 'ayudark'

" Highlights
" ----------
hi ALEErrorLine guifg=#dc322f guibg=#073642 gui=bold
highlight! LspDiagnosticsUnderlineError guibg=#7a1d0c guifg=#ffe0d4 gui=bold
highlight! LspDiagnosticsVirtualTextError guifg=#ff1600 gui=bold
highlight! LspDiagnosticsUnderlineWarning guifg=#ffdf00 guibg=#505050 gui=bold
highlight! LspDiagnosticsVirtualTextWarning guifg=#ffdf00  gui=bold

" Floating
" --------
highlight! NormalFloat guifg=#002b36 guibg=#fdf6e3

" PMenu
" -----
" highlight Pmenu guibg=#073642 guifg=#fdf6e3
