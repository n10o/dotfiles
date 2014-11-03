set number
set incsearch
set ignorecase
set smartcase
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set autoindent
set smartindent
set cinwords=if,elif,else,for,while,try,except,finally,def,class
set nowritebackup
set nobackup
set noswapfile
set list
set formatoptions-=r " disable auto comment
set formatoptions-=o

let g:vim_markdown_folding_disabled=1
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_alto = 1

nnoremap <silent> st :tablast <bar> tabnew<CR>
nnoremap sq :<C-u>q<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sn gt
nnoremap sp gT
nnoremap <silent> si :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>

function! s:Exec()
    exe "!" . &ft . " %"        
:endfunction         
command! Exec call <SID>Exec() 
map <silent> <C-P> :call <SID>Exec()<CR>

""" Unite
let g:unite_enable_start_insert = 1

nnoremap [unite]    <Nop>
nmap     <Space>u [unite]

nnoremap <silent> [unite]f   :<C-u>Unite file<CR>
nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]a   :<C-u>Unite file buffer<CR>
""" VimFiler
let g:vimfiler_as_default_explorer = 1 " netrw replace
" Edit file by tabedit.
"let g:vimfiler_edit_action = 'tabopen'
" IDE lize
"autocmd VimEnter * VimFiler -split -simple -winwidth=30 -no-quit

" SID(use tabline)
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Tabline(tabname)
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
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
set showtabline=2 " 常にタブラインを表示

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
NeoBundle 'pangloss/vim-javascript'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

syntax on

autocmd FileType python setlocal completeopt-=preview
