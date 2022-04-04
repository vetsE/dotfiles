set termguicolors     " Enable true colors support
let &t_ut=''
set background=dark

colorscheme solarized-high
" colorscheme nord
" let g:enfocado_style = "neon"
" let g:enfocado_style = "nature"
" autocmd VimEnter * ++nested colorscheme enfocado

" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" colorscheme ayu

" Statusline
" ----------

" Highlights
" ----------
" hi ALEErrorLine guifg=#dc322f guibg=#073642 gui=bold
highlight! DiagnosticUnderlineError guibg=#7a1d0c guifg=#ffe0d4 gui=bold
highlight! DiagnosticVirtualTextError guifg=#ff1600 gui=bold
highlight! DiagnosticUnderlineWarning guifg=#ffdf00 guibg=#505050 gui=bold
highlight! DiagnosticVirtualTextWarning guifg=#ffdf00  gui=bold

sign define DiagnosticSignError text=✘ texthl=DiagnosticVirtualTextError linehl= numhl=
sign define DiagnosticSignWarn text=▲ texthl=DiagnosticVirtualTextWarning linehl= numhl=
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInformation linehl= numhl=
sign define DiagnosticSignHint text=➤ texthl=DiagnosticSignHint linehl= numhl=

" Floating
" --------
" highlight! NormalFloat guifg=#002b36 guibg=#fdf6e3

" PMenu
" -----
" highlight Pmenu guibg=#073642 guifg=#fdf6e3
