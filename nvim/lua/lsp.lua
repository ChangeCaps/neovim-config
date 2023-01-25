local lspconfig = require('lspconfig')
local cmp = require('cmp')
local dap = require('dap')
local locate_program = require('locate_program')

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	local opts = { noremap = true, silent = true }

	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', '<Space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<Space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Dap
local nvim_home = vim.fn.stdpath('config')
local codelldb_path = nvim_home .. "/vscode_lldb_x86_64_linux/adapter/codelldb"
local liblldb_path = nvim_home .. "/vscode_lldb_x86_64_linux/lldb/lib/liblldb.so"

dap.adapters.codelldb = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)

require('dapui').setup({})

-- Rust setup
local rt = require("rust-tools")
local cargo = require("cargo")

vim.g.rustfmt_autosave = 1 -- Rust format
vim.g.rust_fold = 1 -- Rust fold

locate_program.locaters.rust = function()
	local meta = cargo.metadata()
	local target_dir = meta.target_directory

	local target = cargo.choose_binary_target(meta)
	if target == nil then
		return nil
	end

	cargo.build(target)
	return target_dir .. "/debug/" .. target.name
end

dap.configurations.rust = {
	{
		name = "Launch",
		type = "codelldb",
		request = "launch",
		program = locate_program.locate,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = false,
	},
}

rt.setup({
	-- options same as lsp hover / vim.lsp.util.open_floating_preview()
	hover_actions = {

		-- the border that is used for the hover window
		-- see vim.api.nvim_open_win()
		border = "none",

		-- Maximal width of the hover window. Nil means no max.
		max_width = nil,

		-- Maximal height of the hover window. Nil means no max.
		max_height = nil,

		-- whether the hover action window gets automatically focused
		-- default: false
		auto_focus = true,
	},
	server = {
		on_attach = function(client, bufnr)
			local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
			local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

			on_attach(client, bufnr)

			local opts = { noremap = true, silent = true }

			vim.keymap.set('n', '<Bslash><C-h><Space>', rt.hover_actions.hover_actions, opts)
		end
	},
	dap = {
		adapter = dap.adapters.rust,
	},
})

require('crates').setup({})

-- Lua setup

-- C setup
dap.configurations.c = {
	{
		name = "Launch",
		type = "codelldb",
		request = "launch",
		program = locate_program.locate,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = false,
	},
}
dap.configurations.cpp = dap.configurations.c

lspconfig.clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
})

-- Python setup
lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
})

-- Typescript setup
require("typescript").setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
    },
    server = { -- pass options to lspconfig's setup method
        on_attach = on_attach,
    },
})

-- Svelte setup
lspconfig.svelte.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
})

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup({
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
		{ name = 'path' },
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'nvim_lua' },
		{ name = 'buffer' },
		{ name = 'vsnip' },
		{ name = 'calc' },
		{ name = 'treesitter' },
	},
	formatting = {
		fields = {'menu', 'abbr', 'kind'},
		format = function(entry, item)
			local menu_icon ={
				nvim_lsp = 'λ',
				nvim_lua = '',
				vsnip = '⋗',
				buffer = 'Ω',
				path = '🖫',
			}
			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
})
