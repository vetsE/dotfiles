nmap <F1> <nop>
map <F2> :make!<CR>
" map <F6> :NextColorScheme<CR>
map <F9> :NextColorScheme<CR>
noremap <silent><F10> <cmd>lua vim.lsp.diagnostic.goto_next { enable_popup = false }<CR>
noremap <silent><s-F10> <cmd>lua vim.lsp.diagnostic.goto_prev { enable_popup = false }<CR>

noremap è ^
noremap È 0

nmap <silent><leader>t :bnext<CR>
nmap <silent><leader>c :bprevious<CR>
nmap <silent><leader>e <C-o>
nmap <silent><leader>i <C-i>
nmap <silent><leader>q :bp <BAR> bd #<CR>
nmap <silent><leader>o :RnvimrToggle<CR>
nmap <silent><leader>D <cmd>lua vim.lsp.buf.type_definition()<CR>
nmap <silent><leader>d <cmd>lua vim.lsp.buf.definition()<CR>
nmap <silent><leader>k <cmd>lua vim.lsp.buf.hover()<CR>

imap   <Space>
