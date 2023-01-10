-- Map leader
vim.g.mapleader = " "
vim.cmd("filetype off")

---- Vim plug ----
require("plug")

---- LSP ----
require("lsp")

---- Options ----
require("opts")

---- Keymaps ----
require("keys")

---- Commands ----
require("commands")

---- Settings ----
-- Colorscheme
vim.cmd [[ set background=dark ]]
vim.cmd [[ colorscheme kanagawa ]]

-- Syntax highlighting
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

-- Split
vim.cmd("set splitright")
vim.cmd("set splitbelow")
vim.cmd("set mouse=a")

vim.cmd("map <C-p> :Files<CR>")

-- Spelling check
vim.cmd("set spell spelllang=en_us")

-- Indentation
vim.cmd("set autoindent")
vim.cmd("set encoding=utf-8")

vim.opt.shiftwidth = 4
vim.opt.softtabstop = 8
vim.opt.tabstop = 4

-- Autoformat
vim.cmd("au BufWrite * :Autoformat")
vim.cmd("au FileType yaml let b:autoformat_autoindent=0")

-- Line number
vim.cmd("set number relativenumber")

-- Treesitter
require("nvim-treesitter.configs").setup {
	ensure_installed = { "lua", "rust", "toml" },
	auto_install = true,
	highlight = {
		enabled = true,
		additional_vim_regex_highlighting = false,
	},
	ident = { enable = true },
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	}
}

-- Github copilot
vim.cmd("imap <silent><script><expr> <S-CR> copilot#Accept(\"\")")
vim.cmd("let g:copilot_no_tab_map = v:true")
