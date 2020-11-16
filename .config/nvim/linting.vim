" nvim lsp
lua <<EOF

local on_attach = function(_, bufnr)
    require'diagnostic'.on_attach()
    require'completion'.on_attach()
end

require'nvim_lsp'.pyls.setup{
    on_attach=on_attach,
    settings={
      pyls = {
        plugins = {
            pyls_mypy = {
                enabled = true,
            },
            pycodestyle = {
                enabled = false
                }
            }
        }
    }
}
EOF


lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,  -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },
  indent = {
    enable = true
    }
}
EOF

lua <<EOF
vim.lsp.callbacks['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.callbacks['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.callbacks['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.callbacks['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.callbacks['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.callbacks['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.callbacks['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.callbacks['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
EOF

let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_auto_popup_while_jump = 0

call sign_define("LspDiagnosticsErrorSign", {"text" : "✘", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "▲", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "I", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "H", "texthl" : "LspDiagnosticsHint"})

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
"   \           'signText': '▲',
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
let g:ale_linters = {'html': ['HTMLHint'], 'javascript': ['jshint'], 'css': ['csslint'], 'python': ['mypy', 'pylint']}

hi ALEErrorLine guifg=#dc322f guibg=#073642 gui=bold



augroup AutoFormatting
    autocmd BufWritePre *.py undojoin | Neoformat black
    " autocmd BufWritePre *.py execute ':ALEFix black'
    " autocmd BufWritePre *.rs execute ':call CocAction("format")'
augroup END
" let g:ale_completion_enable = 1
"
let g:languagetool_jar="/home/vetse/.local/share/languagetool/languagetool-commandline.jar"
let g:languagetool_lang="fr"

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" " Use <c-space> to trigger completion.
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif

" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" " position. Coc only does snippet and additional edit on confirm.
" " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
" if exists('*complete_info')
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif

" call coc#config('coc.preferences', {
" \ 'messageLevel': 'error',
" \})
"
let g:diagnostic_insert_delay = 1
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
