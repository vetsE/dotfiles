map <F1> <nop>
map <F2> :make!<CR>
nmap <silent><F3> <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
noremap <silent><F10> <cmd>lua vim.lsp.diagnostic.goto_next { enable_popup = false }<CR>
noremap <silent><s-F10> <cmd>lua vim.lsp.diagnostic.goto_prev { enable_popup = false }<CR>

noremap è ^
noremap È 0

let g:ranger_map_keys = 0

nmap <silent><leader><leader> :b#<cr>
nmap <silent><leader>t :BufferNext<CR>
nmap <silent><leader>c :BufferPrevious<CR>
nmap <silent><leader>e <C-o>
nmap <silent><leader>i <C-i>
nmap <silent><leader>m :make!<CR>
nmap <silent><leader>q :bp <BAR> bd #<CR>
nmap <silent><leader>o :Ranger<CR>
nmap <silent><leader>D <cmd>lua vim.lsp.buf.type_definition()<CR>
nmap <silent><leader>d <cmd>lua vim.lsp.buf.definition()<CR>
nmap <silent><leader>k <cmd>lua vim.lsp.buf.hover()<CR>
nmap <silent><leader>w <cmd>TroubleToggle lsp_document_diagnostics<CR>
nmap <silent><leader>z <cmd>TodoTrouble<CR>
nmap <silent><leader>é <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nmap <silent><leader>f <cmd>Telescope find_files<cr>
nmap <silent><leader>g <cmd>Telescope live_grep<cr>
nmap <silent><leader>b <cmd>Telescope buffers<cr>
nmap <silent><leader>W <cmd>Telescope lsp_document_diagnostics<cr>
nmap <silent><leader>- yypVj-<cr>
nmap <silent><leader>= yypVj=<cr>

tnoremap <Esc> <C-\><C-n>

nmap <silent><leader>s :wa<CR>
nmap <silent><leader><cr> :noh<cr>

nmap <M-t> mz:m+<cr>`z
nmap <M-s> mz:m-2<cr>`z
vmap <M-t> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-s> :m'<-2<cr>`>my`<mzgv`yo`z

imap   <Space>

" Vimtex
let g:vimtex_mappings_disable = {
    \ 'n': ['tse', 'tsd', 'tsc', 'tsf', 'tsD', 'csd', 'csc', 'cse', 'cs$'],
    \ 'x': ['tsd'],
    \}

