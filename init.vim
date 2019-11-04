set shell=/bin/bash
let mapleader = "\<Space>"



set nocompatible
filetype off
call plug#begin()

Plug 'itchyny/lightline.vim'

Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'chriskempson/base16-vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'rust-lang/rust'

call plug#end()

colorscheme base16-atelier-dune
set termguicolors

set splitright
set splitbelow

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

map <C-p> :Files<CR>

filetype plugin indent on
set autoindent
set encoding=utf-8

set shiftwidth=8
set softtabstop=8
set tabstop=8
set noexpandtab

set number relativenumber

" Mappings

map <C-h> _
map <C-l> $
map <C-k> 10k
map <C-j> 10j

nmap <leader>w :w<CR>
noremap <leader><leader> <C-w><C-w> 

inoremap {<CR> {<CR>}<Up><Esc>A<CR><Space><BackSpace>

nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

nmap <silent> E <Plug>(coc-diagnostic-prev)
nmap <silent> W <Plug>(coc-diagnostic-next)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
