syntax on
set number
set incsearch
set ignorecase
set smartcase
set wildmenu wildmode=list:longest,list:full " menu has tab completion
set cinwords=if,elif,else,for,while,try,except,finally,def,class
set list
set ruler " show the cursor position
set hlsearch " highlight search result
set laststatus=2

set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

set autoindent
set smartindent

augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

set nowritebackup
set nobackup
set noswapfile

set mouse=a
set ttymouse=xterm2

let g:vim_markdown_folding_disabled=1
let g:vimfiler_as_default_explorer = 1 " netrw replace

" rapid jj means ESC
inoremap jj <Esc> 
" disable highlight search result
nmap <silent> <Esc><Esc> :nohlsearch<CR>

nnoremap <silent> st :tablast <bar> tabnew<CR>
nnoremap sq :<C-u>q<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sn gt
nnoremap sp gT
nnoremap <silent> si :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>

""" Unite
let g:unite_enable_start_insert = 1

nnoremap [unite]    <Nop>
nmap     <Space>u [unite]

nnoremap <silent> [unite]f   :<C-u>Unite file<CR>
nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]a   :<C-u>Unite file buffer<CR>

""" Tabline(tabname)
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]
    let no = i
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = title
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " always display

""" NeoBundle
if has('vim_starting')
  set nocompatible               " Be iMproved
  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimshell'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'thinca/vim-quickrun' " :QuickRun
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'pangloss/vim-javascript'
" NeoBundle 'kien/ctrlp.vim'
call neobundle#end()

filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

autocmd FileType python setlocal completeopt-=preview
