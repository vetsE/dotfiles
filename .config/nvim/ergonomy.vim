" Ranger configuration
" --------------------

" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1

" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1

" Signifdexpr=nvim_treesitter#foldexpr()

" Lsp and stuff
" -------------
let g:lsp_document_highlight_enabled = 0

let b:ale_linters = {'python': ['vim-lsp', 'bandit']}

if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif


" Folding
" -------
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
au BufRead * normal zR


" Gutter
" ------
let g:signify_priority = 5
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '▲'
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Snippets
" --------


" Autocompletion
" --------------
autocmd BufEnter * call ncm2#enable_for_buffer()
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")


" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
        \ 'name' : 'css',
        \ 'priority': 9,
        \ 'subscope_enable': 1,
        \ 'scope': ['css','scss'],
        \ 'mark': 'css',
        \ 'word_pattern': '[\w\-]+',
        \ 'complete_pattern': ':\s*',
        \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
        \ })
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
" let g:compe.documentation = v:true

" let g:compe.source = {}
" let g:compe.source.path = v:true
" let g:compe.source.buffer = v:true
" let g:compe.source.calc = v:true
" let g:compe.source.nvim_lsp = v:true
" let g:compe.source.nvim_lua = v:true
" let g:compe.source.vsnip = v:false
" let g:compe.source.ultisnips = v:true

" inoremap <silent><expr> <C-b> compe#complete()

" Avoid showing message extra message when using completion
set completeopt=menuone,noselect

" Autoformat
" ----------
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black', 'isort', 'add_blank_lines_for_python_control_statements'],
\}
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * silent! undojoin | FiletypeFormat
" augroup END

" Comments
"---------
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
