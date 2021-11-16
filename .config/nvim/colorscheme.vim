set termguicolors     " Enable true colors support
let &t_ut=''
set background=dark

colorscheme OceanicNext
" colorscheme nord
" let g:enfocado_style = "neon"
" let g:enfocado_style = "nature"
" autocmd VimEnter * ++nested colorscheme enfocado


" Statusline
" ----------

" Highlights
" ----------
" hi ALEErrorLine guifg=#dc322f guibg=#073642 gui=bold
highlight! LspDiagnosticsUnderlineError guibg=#7a1d0c guifg=#ffe0d4 gui=bold
highlight! LspDiagnosticsVirtualTextError guifg=#ff1600 gui=bold
highlight! LspDiagnosticsUnderlineWarning guifg=#ffdf00 guibg=#505050 gui=bold
highlight! LspDiagnosticsVirtualTextWarning guifg=#ffdf00  gui=bold
sign define LspDiagnosticsSignError text=✘ texthl=LspDiagnosticsVirtualTextError linehl= numhl=
sign define LspDiagnosticsSignWarning text=▲ texthl=LspDiagnosticsVirtualTextWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text=➤ texthl=LspDiagnosticsSignHint linehl= numhl=


" Floating
" --------
" highlight! NormalFloat guifg=#002b36 guibg=#fdf6e3

" PMenu
" -----
" highlight Pmenu guibg=#073642 guifg=#fdf6e3
