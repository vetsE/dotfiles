"
" autocmd BufWritePre *.rs execute ':ALEFix rustfmt'
" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" let g:LanguageClient_useFloatingHover = 1
" let g:LanguageClient_useVirtualText = 0
" let g:LanguageClient_serverCommands = {
"     \ 'python': ['/usr/bin/pyls'],
"     \ 'html': ['/usr/bin/html-languageserver'],
" \ }

" let g:LanguageClient_diagnosticsEnable = 0

" let diagnosticsDisplaySettings={
"   \       '1': {
"   \           'name': 'Error',
"   \           'texthl': 'ALEError',
"   \           'signText': '✘',
"   \           'signTexthl': 'ALEErrorSign',
"   \       },
"   \       '2': {
"   \           'name': 'Warning',
"   \           'texthl': 'ALEWarning',
"   \           'signText': '▲"',
"   \           'signTexthl': 'ALEWarningSign',
"   \       },
"   \       '3': {
"   \           'name': 'Information',
"   \           'texthl': 'ALEInfo',
"   \           'signText': '",',
"   \           'signTexthl': 'ALEInfoSign',
"   \       },
"   \       '4': {
"   \           'name': 'Hint',
"   \           'texthl': 'ALEInfo',
"   \           'signText': '➤"',
"   \           'signTexthl': 'ALEInfoSign',
"   \       },
"   \  }

" let g:LanguageClient_diagnosticsDisplay=diagnosticsDisplaySettings

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '▲'
" let g:ale_sign_warning = '⚠'
let g:ale_python_pylint_options = '--disable=logging-fstring-interpolation'
let g:ale_python_mypy_options = '--ignore-missing-imports --follow-imports=skip'
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_c_parse_makefile = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%, %severity%] %code%: %s'
let g:ale_linters = {'html': ['HTMLHint'], 'javascript': ['jshint'], 'css': ['csslint'], 'python': ['mypy', 'pylint', 'pyls']}


augroup AutoFormatting
    autocmd BufWritePre *.py execute ':ALEFix black'
    autocmd BufWritePre *.rs execute ':ALEFix rustfmt'
augroup END
" let g:ale_completion_enable = 1
"
let g:languagetool_jar="/usr/bin/languagetool"
let g:languagetool_lang="fr"

