set number
set incsearch
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set autoindent
set smartindent
set cinwords=if,elif,else,for,while,try,except,finally,def,class

let g:vim_markdown_folding_disabled=1
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_alto = 1

function! s:Exec()
    exe "!" . &ft . " %"        
:endfunction         
command! Exec call <SID>Exec() 
map <silent> <C-P> :call <SID>Exec()<CR>

""" Unite.vim
let g:unite_enable_start_insert = 1
let g:vimfiler_as_default_explorer = 1 " netrw replace
" Edit file by tabedit.
"let g:vimfiler_edit_action = 'tabopen'

nnoremap [unite]    <Nop>
nmap     <Space>u [unite]

nnoremap <silent> [unite]f   :<C-u>Unite file<CR>
nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]a   :<C-u>Unite file buffer<CR>
"""

if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimshell'
NeoBundle 'tpope/vim-fugitive'
" NeoBundle 'kien/ctrlp.vim'
NeoBundle 'thinca/vim-quickrun' " :QuickRun
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'plasticboy/vim-markdown'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

syntax on
