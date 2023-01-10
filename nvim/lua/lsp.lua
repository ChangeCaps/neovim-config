local lspconfig = require('lspconfig')
local cmp = require('cmp')
local dap = require('dap')

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

dap.adapters.vscode_lldb = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)

require('dapui').setup({})

-- Rust setup
local rt = require("rust-tools")
local cargo = require("cargo")

dap.configurations.rust = {
	{
		name = "Launch",
		type = "vscode_lldb",
		request = "launch",
		program = function()
			local meta = cargo.metadata()
			local target_dir = meta.target_directory

			local targets = cargo.binary_targets(meta)

			-- if we have no targets, we can't debug anything
			if #targets == 0 then
				return nil
			end

			-- if we have only one target, just return it
			if #targets == 0 then
				cargo.build(targets[1].name)
				return target_dir .. "/debug/" .. targets[1].name
			end

			-- if we have multiple, let the user choose
			local choices = {}

			for i, target in ipairs(targets) do
				local target_choice = i .. ". " .. target.name .. " (" .. target.crate_types[1] .. ")"

				table.insert(choices, target_choice)
			end

			local choice = vim.fn.inputlist(choices)

			if choice == 0 then
				return nil
			end

			cargo.build(targets[choice].name)
			return target_dir .. "/debug/" .. targets[choice].name
		end,
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

require('crates').setup({
	loading_indicator = false,
})

-- Lua setup

-- C setup
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
