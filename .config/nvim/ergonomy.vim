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

" File manager
" ------------
let g:rnvimr_enable_ex = 1 " Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_picker = 1 " Make Ranger to be hidden after picking a file
let g:rnvimr_layout = {
           \ 'relative': 'editor',
           \ 'width': &columns,
           \ 'height': &lines - 2,
           \ 'col': 0,
           \ 'row': 0,
           \ 'style': 'minimal'
           \ }

" Autoformat
" ----------
augroup fmt
  autocmd!
  au BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
augroup END

let g:neoformat_c_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['-style=file'],
            \ 'stdin': 1,
            \ }

let g:neoformat_cmake_cmakeformat = {
            \ 'exe': 'cmake-format',
            \ 'stdin': 1,
            \ }

" let g:neoformat_c_clangformat = {
"             \ 'exe': 'clang-format',
"             \ 'args': ['-style=file']
"             \ }


let g:neoformat_python_isort = {
            \ 'exe': 'isort',
            \ 'args': ['-', '--quiet', '--profile', 'black'],
            \ 'stdin': 1,
            \ }

let g:neoformat_python_black = {
            \ 'exe': 'black',
            \ 'stdin': 1,
            \ 'args': ['-q', '-', '--target-version', 'py310', ' --line-length', '96'],
            \ }

let g:neoformat_enabled_markdown = []
let g:neoformat_enabled_python = ['black', 'isort', 'docformatter']
let g:neoformat_enabled_rust = ["rustfmt"]
let g:neoformat_enabled_c = []
let g:neoformat_enabled_cpp = []

let g:neoformat_basic_format_align = 0
let g:neoformat_basic_format_trim = 1
let g:neoformat_only_msg_on_error = 0

let g:signify_priority = 5


" Barbar
let bufferline = get(g:, 'bufferline', {})
" Enable/disable auto-hiding the tab bar when there is a single buffer
let bufferline.auto_hide = v:true
" Enable/disable close button
let bufferline.closable = v:false


