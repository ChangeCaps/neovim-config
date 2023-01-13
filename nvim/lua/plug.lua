local Plug = vim.fn["plug#"]
vim.call('plug#begin', '~/.config/nvim/plugged')

-- Rooter
Plug 'airblade/vim-rooter'

-- Fuzzy finder
Plug('junegunn/fzf', { ['dir'] = '~/.fzf', ['do'] = './install --all' })
Plug 'junegunn/fzf.vim'

-- Colorscheme
Plug 'rebelot/kanagawa.nvim'

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

-- File explorer
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

-- Debugging
Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

-- Treesitter
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

---- Languages ----
Plug 'mfussenegger/nvim-jdtls' -- Java
Plug 'simrat39/rust-tools.nvim' -- Rust
Plug 'Saecki/crates.nvim' -- Rust
Plug 'rust-lang/rust.vim' -- Rust

-- Shading languages
Plug 'tikhomirov/vim-glsl' -- GLSL
Plug 'beyondmarc/hlsl.vim' -- HLSL

vim.call('plug#end')
