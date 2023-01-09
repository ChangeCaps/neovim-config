local Plug = vim.fn["plug#"]
vim.call('plug#begin', '~/.config/nvim/plugged')

-- Light line
Plug 'itchyny/lightline.vim'

-- Rooter
Plug 'airblade/vim-rooter'

-- Fuzzy finder
Plug('junegunn/fzf', { ['dir'] = '~/.fzf', ['do'] = './install --all' })
Plug 'junegunn/fzf.vim'

-- Base 16 color scheme
Plug 'chriskempson/base16-vim'

-- Neovim lsp
Plug 'neovim/nvim-lspconfig'
Plug('hrsh7th/cmp-nvim-lsp', {['branch'] = 'main'})
Plug('hrsh7th/cmp-buffer', {['branch'] = 'main'})
Plug('hrsh7th/cmp-path', {['branch'] = 'main'})
Plug('hrsh7th/nvim-cmp', {['branch'] = 'main'})
Plug 'ray-x/lsp_signature.nvim'

-- Github copilot
Plug 'github/copilot.vim'

-- Only because nvim-cmp _requires_ snippets
Plug('hrsh7th/cmp-vsnip', {['branch'] = 'main'})
Plug 'hrsh7th/vim-vsnip'

-- Debugging
Plug 'puremourning/vimspector'

-- Treesitter
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate*'})

---- Languages ----
Plug 'mfussenegger/nvim-jdtls' -- Java
Plug 'rust-lang/rust.vim'      -- Rust

-- Shading languages
Plug 'tikhomirov/vim-glsl' -- GLSL
Plug 'beyondmarc/hlsl.vim' -- HLSL

vim.call('plug#end')
