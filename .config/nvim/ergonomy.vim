" Ranger configuration
" --------------------

" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1

" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1

" Signifdexpr=nvim_treesitter#foldexpr()

" Lsp and stuff
" -------------

" Folding
" -------
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" Gutter
" ------
let g:signify_priority = 5
sign define LspDiagnosticsSignError text=✘ texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text=▲ texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text=➤ texthl=LspDiagnosticsSignHint linehl= numhl=

" Snippets
" --------


" Autocompletion
" --------------

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:false
let g:compe.source.ultisnips = v:true

inoremap <silent><expr> <C-b> compe#complete()

" " Avoid showing message extra message when using completion
set completeopt=menuone,noselect

" Autoformat
" ----------
augroup fmt
  autocmd!
  autocmd BufWritePre * silent! undojoin | FiletypeFormat
augroup END

let g:vim_filetype_formatter_commands = {
      \ 'python': 'black -q - | isort -q - | docformatter -',
      \ }

" let g:neoformat_enabled_markdown = ["prettier"]
" let g:neoformat_enabled_python = ["black"]
" let g:neoformat_basic_format_align = 1
" let g:neoformat_basic_format_trim = 1
" let g:neoformat_only_msg_on_error = 1

" Comments
autocmd FileType javascript.jsx setlocal commentstring={/*\ %s\ */}
