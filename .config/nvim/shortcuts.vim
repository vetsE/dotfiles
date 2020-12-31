nmap <F1> <nop>
map <F2> :make!<CR>
map <F6> :NextColorScheme<CR>
let g:floaterm_keymap_toggle = '<F9>'
" noremap <silent><F12> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nmap <silent><F12> :call CocAction('diagnosticNext')<CR>
nmap <silent><s-F11> :call CocAction('diagnosticPrevious')<CR>


noremap è ^
noremap È 0

nmap <silent><leader>n :bnext<CR>
nmap <silent><leader>c :bprevious<CR>
nmap <silent><leader>t <C-o>
nmap <silent><leader>s <C-i>
nmap <silent><leader>q :bp <BAR> bd #<CR>
nmap <silent><leader>o :RnvimrToggle<CR>
nmap <silent><leader>D <cmd>lua vim.lsp.buf.declaration()<CR>
nmap <silent><leader>d <cmd>lua vim.lsp.buf.definition()<CR>
nmap <silent><leader>k <cmd>lua vim.lsp.buf.hover()<CR>
nmap <silent><leader>r <cmd>lua vim.lsp.buf.type_definition()<CR>

imap   <Space>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
    \ pumvisible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
