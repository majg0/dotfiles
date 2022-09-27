""""""""
" MOVE "
""""""""

" Disable arrow keys for Normal, Visual, Select and Operator-pending modes
" see noremap and map-modes
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

""""""""""
" VISUAL "
""""""""""

" Display relative line numbers
set number
set relativenumber

" Remove search highlights on ESC
noremap <ESC> :nohls<cr>

"""""""
" FZF "
"""""""

set rtp+=/usr/local/opt/fzf
nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>F :FZF ~<cr>

"""""""
" LUA "
"""""""

lua require('init')
