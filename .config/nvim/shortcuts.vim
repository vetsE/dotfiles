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
nmap <silent><leader>D <Plug>(coc-type-definition)
nmap <silent><leader>d :call CocActionAsync('jumpDefinition')<CR>
nmap <silent><leader>k :call <SID>show_documentation()<CR>


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

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
