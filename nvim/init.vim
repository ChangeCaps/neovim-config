let mapleader = "\<Space>"

set nocompatible
filetype off

call plug#begin()

Plug 'itchyny/lightline.vim'

Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'chriskempson/base16-vim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}

Plug 'github/copilot.vim'

" Only because nvim-cmp _requires_ snippets
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'

" Glsl
Plug 'tikhomirov/vim-glsl'

" java
Plug 'mfussenegger/nvim-jdtls'

Plug 'rust-lang/rust.vim'

call plug#end()

colorscheme base16-atelier-dune
set termguicolors

syntax on
filetype plugin indent on

set splitright
set splitbelow
set mouse=a

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

lua << END
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()

local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

if not configs.wgsl_analyzer then
	configs.wgsl_analyzer = {
		default_config = {
			cmd = { vim.fn.expand("$HOME") .. "/.cargo/bin/wgsl_analyzer" },
			filetypes = { "wgsl" },
			root_dir = lspconfig.util.root_pattern(".git", "wgsl"),
			settings = {},
		},
	}
end

local on_attach = function(client, bufnr)	
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }

  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<Space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'wgsl_analyzer', 'pyright' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    -- REQUIRED by nvim-cmp. get rid of it once we can
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  }, 
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
  },
}
END

map <C-p> :Files<CR>

" Spell check
set spell spelllang=en_us

" Rust
let g:rustfmt_autosave = 1


set autoindent
set encoding=utf-8

set shiftwidth=4
set softtabstop=8
set tabstop=4
set noexpandtab

set number relativenumber

set completeopt=menuone,noinsert,noselect

" Copilot
imap <silent><script><expr> <S-CR> copilot#Accept("")
let g:copilot_no_tab_map = v:true

" Mappings

noremap <C-h> _
noremap <C-l> $
noremap <C-k> 10k
noremap <C-j> 10j

nmap <leader>w :w<CR>
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>l <C-w>l
nmap <leader><leader> m
nmap m <C-w><C-w>

inoremap {<CR> {<CR>}<Up><Esc>A<CR><Space><BackSpace>

nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
