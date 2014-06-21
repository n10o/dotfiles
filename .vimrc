set number
set incsearch
setlocal shiftwidth=4
setlocal tabstop=8
setlocal softtabstop=4
setlocal expandtab
setlocal autoindent
setlocal smartindent
setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class

let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_alto = 1

if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'Yggdroot/indentLine'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

syntax on
