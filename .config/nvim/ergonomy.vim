
" Comments
autocmd FileType javascript.jsx setlocal commentstring={/*\ %s\ */}


" Return to last edit position when opening files
" -----------------------------------------------
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Persistent undo
" ---------------
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

" Snippets
" --------
" Expand or jump
imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Autoformat
" ----------
augroup fmt
  autocmd!
  au BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
augroup END

let g:neoformat_enabled_markdown = []
let g:neoformat_enabled_python = ["black", "isort", "docformatter"]
let g:neoformat_enabled_rust = ["rustfmt"]
let g:neoformat_basic_format_align = 0
let g:neoformat_basic_format_trim = 1
let g:neoformat_only_msg_on_error = 0

" let g:compe = {}
" let g:compe.enabled = v:true
" let g:compe.autocomplete = v:true
" let g:compe.debug = v:false
" let g:compe.min_length = 1
" let g:compe.preselect = 'enable'
" let g:compe.throttle_time = 80
" let g:compe.source_timeout = 200
" let g:compe.incomplete_delay = 400
" let g:compe.max_abbr_width = 100
" let g:compe.max_kind_width = 100
" let g:compe.max_menu_width = 100
" let g:compe.documentation = v:false

" let g:compe.source = {}
" let g:compe.source.path = v:true
" let g:compe.source.buffer = v:true
" let g:compe.source.calc = v:true
" let g:compe.source.nvim_lsp = v:true
" let g:compe.source.nvim_lua = v:true
" let g:compe.source.vsnip = v:true
" let g:compe.source.ultisnips = v:false

inoremap <silent><expr> <C-b> compe#complete()

" " Avoid showing message extra message when using completion
set completeopt=menuone,noselect
" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1

" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1
let g:signify_priority = 5


" Barbar
let bufferline = get(g:, 'bufferline', {})
" Enable/disable auto-hiding the tab bar when there is a single buffer
let bufferline.auto_hide = v:true
" Enable/disable close button
let bufferline.closable = v:false


