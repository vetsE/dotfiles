" Indent line
" -----------
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2

" Lsp/diagnostic

" buffer line
let bufferline = get(g:, 'bufferline', {})
let bufferline.auto_hide = v:true
let bufferline.closable = v:false

