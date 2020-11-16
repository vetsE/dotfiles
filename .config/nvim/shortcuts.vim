" noremap <F12> :cn<CR>
" noremap <F12> :ALENextWrap<CR>
noremap <silent><F12> :NextDiagnosticCycle<CR>
noremap è ^
noremap È 0
nmap <F1> <nop>
imap <F1> <nop>
map <F2> :make -B<CR>
nmap gé :bnext<CR>
nmap gb :bprevious<CR>
nmap <leader>gq :bp <BAR> bd #<CR>
nmap gl :ls<CR>
nmap gt :b 
imap   <Space>

" imap <F9> <ESC>:Vista!!<CR>
" nmap <F9> <ESC>:Vista!!<CR>
let g:floaterm_keymap_toggle = '<F10>'

" nmap <leader>d :ALEGoToDefinition<CR>
nmap <leader>b <C-o>
nmap <leader>é <C-i>

" GoTo code navigation.
" nmap <silent> <leader>d <Plug>(coc-definition)
" nmap <silent> <leader>y <Plug>(coc-type-definition)
" nmap <silent> <leader>i <Plug>(coc-implementation)
" nmap <silent> <leader>r <Plug>(coc-references)

" Use K to show documentation in preview window.
" nnoremap <silent> <leader>k :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

imap <f9> <ESC>:make<CR>
nmap <f9> <ESC>:make<CR>

nnoremap <silent><leader>D    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent><leader>d <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent><leader>k     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent><leader>r     <cmd>lua vim.lsp.buf.type_definition()<CR>

silent! nunmap cs
silent! nunmap css
