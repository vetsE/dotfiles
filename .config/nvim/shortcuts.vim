nmap <F1> <nop>
map <F2> :make!<CR>
" map <F6> :NextColorScheme<CR>
map <F9> :NextColorScheme<CR>

noremap <silent><F10> :ALENextWrap<CR>
noremap <silent><s-F10> :ALEPreviousWrap<CR>

noremap è ^
noremap È 0

nmap <silent><leader>t :bnext<CR>
nmap <silent><leader>c :bprevious<CR>
nmap <silent><leader>e <C-o>
nmap <silent><leader>i <C-i>
nmap <silent><leader>q :bp <BAR> bd #<CR>
nmap <silent><leader>o :RnvimrToggle<CR>

nmap <silent><leader>d <plug>(lsp-definition)
nmap <silent><leader>D <plug>(lsp-type-definition)
nmap <silent><leader>k <plug>(lsp-hover)

nmap <silent><leader>s :wa<CR>
nmap <silent><leader>Q :q<CR>
nmap <silent><leader><cr> :noh<cr>

imap   <Space>

nmap <M-t> mz:m+<cr>`z
nmap <M-s> mz:m-2<cr>`z
vmap <M-t> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-s> :m'<-2<cr>`>my`<mzgv`yo`z


command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

