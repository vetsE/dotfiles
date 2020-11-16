set hidden  " allow buffer switching without saving
set showtabline=2  " always show tabline

" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#coc#enabled ='0'
" let g:airline_section_c = '%t'


 " use lightline-buffer in lightline
 " The colorscheme for lightline.vim.
 " Currently, wombat, solarized, powerline, powerlineish,
 " jellybeans, molokai, seoul256, darcula, selenized_dark,
 " Tomorrow, Tomorrow_Night, Tomorrow_Night_Blue,
 " Tomorrow_Night_Bright, Tomorrow_Night_Eighties, PaperColor,
 " landscape, one, materia, material, OldHope, nord, deus,
 " srcery_drk, ayu_mirage and 16color are available.

 let g:lightline = {
     \ 'colorscheme': 'solarized',
     \ 'tabline': {
     \   'left': [ 
     \             [ 'separator' ],
     \             [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
     \   'right': [ [ 'close' ], ],
     \ },
     \ 'active': {
     \   'left': [ [ 'mode', 'paste' ],
     \             [ 'readonly', 'modified', 'filename'] ],
     \   'right': [ [ 'currentfunction'],
     \              [ 'percent', 'lineinfo' ],
     \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
     \ },
     \ 'component_expand': {
     \   'buffercurrent': 'lightline#buffer#buffercurrent',
     \   'bufferbefore': 'lightline#buffer#bufferbefore',
     \   'bufferafter': 'lightline#buffer#bufferafter',
     \ },
     \ 'component_type': {
     \   'buffercurrent': 'tabsel',
     \   'bufferbefore': 'raw',
     \   'bufferafter': 'raw',
     \ },
     \ 'component': {
     \   'separator': '',
     \   'tagbar': '%{tagbar#currenttag("%s", "", "f")}',
     \ },
     \ 'component_function': {
     \   'filename': 'LightlineFilename',
     \ }
     \ }


" " remap arrow keys
" nnoremap <Left> :bprev<CR>
" nnoremap <Right> :bnext<CR>

" " lightline-buffer ui settings
" " replace these symbols with ascii characters if your environment does not support unicode
let g:lightline_buffer_logo = ' '
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = '✭'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_ellipsis_icon = '..'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
let g:lightline_buffer_separator_icon = '  '

" enable devicons, only support utf-8
" require <https://github.com/ryanoasis/vim-devicons>
let g:lightline_buffer_enable_devicons = 1

" lightline-buffer function settings
let g:lightline_buffer_show_bufnr = 1

" :help filename-modifiers
let g:lightline_buffer_fname_mod = ':t'

" hide buffer list
let g:lightline_buffer_excludes = ['vimfiler']

" max file name length
let g:lightline_buffer_maxflen = 30

" max file extension length
let g:lightline_buffer_maxfextlen = 3

" min file name length
let g:lightline_buffer_minflen = 16

" min file extension length
let g:lightline_buffer_minfextlen = 3

" reserve length for other component (e.g. info, close)
let g:lightline_buffer_reservelen = 20

function! LightlineFilename()
  return expand('%')
endfunction
