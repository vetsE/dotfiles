" Ranger configuration
" --------------------

" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1

" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1

" Signifdexpr=nvim_treesitter#foldexpr()

" Lsp and stuff
" -------------
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '▲'
let g:ale_python_pylint_options = '--disable=logging-fstring-interpolation'
let g:ale_python_mypy_options = '--ignore-missing-imports --follow-imports=skip'
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_c_parse_makefile = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%, %severity%] %code%: %s'
" let g:ale_linters = {'html': ['HTMLHint'], 'javascript': ['jshint'], 'css': ['csslint'], 'python': ['mypy', 'pylint', 'pyright']}
let g:ale_linters = {}
let g:ale_fixers = {'python': ['black', 'isort']}
let g:ale_fix_on_save = 1
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif
