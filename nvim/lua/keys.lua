local ignore = { noremap = true, silent = true }
local silent = { silent = true }

-- Debugging (nvim-dap)
function launch_with_args()
	local locate_program = require('locate_program')

	local program = locate_program.locate()
	local args = vim.fn.input("Enter program arguments: ", "", "file")

	local dap = require('dap')
	local config = vim.deepcopy(dap.configurations[vim.bo.filetype][1])

	config.program = program

	for _, arg in ipairs(vim.split(args, " ")) do
		table.insert(config.args, arg)
	end

	dap.run(config)
end

vim.keymap.set("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", ignore)
vim.keymap.set("n", "<F6>", launch_with_args, ignore)
vim.keymap.set("n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>", ignore)
vim.keymap.set("n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>", ignore)
vim.keymap.set("n", "<F12>", "<cmd>lua require'dap'.step_out()<CR>", ignore)
vim.keymap.set("n", "<F8>", "<cmd>lua require'dapui'.toggle()<CR>", ignore)

vim.keymap.set("n", "<leader>d", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", ignore)
vim.keymap.set("n", "<F4>", "<cmd>lua require'dap'.clear_breakpoints()<CR>", ignore)

---- Vim keymaps ----
-- Move lines
vim.keymap.set("n", "<C-h>", "_", ignore)
vim.keymap.set("n", "<C-l>", "$", ignore)
vim.keymap.set("n", "<C-k>", "10k", ignore)
vim.keymap.set("n", "<C-j>", "10j", ignore)

vim.keymap.set("v", "<C-h>", "_", ignore)
vim.keymap.set("v", "<C-l>", "$", ignore)
vim.keymap.set("v", "<C-k>", "10k", ignore)
vim.keymap.set("v", "<C-j>", "10j", ignore)

-- Move between windows
vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>l", "<C-w>l")
vim.keymap.set("n", "<leader><leader>", "<C-w><C-w>", ignore)

-- Tab navigation
for i = 1, 9 do
	vim.keymap.set("n", "<leader>" .. i, "<cmd>tabnext " .. i .. "<CR>")
end

-- Close tab
vim.keymap.set("n", "<leader>q", ":tabclose<CR>")

-- New tab
vim.keymap.set("n", "<leader>t", ":tabnew<CR>")

-- Save
vim.keymap.set("n", "<leader>w", ":w<CR>")

vim.keymap.set("i", "{<CR>", "{<CR>}<Up><Esc>A<CR><Space><BackSpace>")

vim.keymap.set("i", "(<Space>", "(<CR>)<left><BackSpace>", ignore)
vim.keymap.set("i", "[<Space>", "[<CR>]<left><BackSpace>", ignore)
vim.keymap.set("i", "<<Space>", "<<CR>><left><BackSpace>", ignore)

vim.keymap.set("n", "<up>", "<nop>", ignore)
vim.keymap.set("n", "<down>", "<nop>", ignore)
vim.keymap.set("i" ,"<up>", "<nop>", ignore)
vim.keymap.set("i", "<down>", "<nop>", ignore)
vim.keymap.set("i", "<left>", "<nop>", ignnore)
vim.keymap.set("i", "<right>", "<nop>", ignore)

vim.keymap.set("n", "<left>", ":bn<CR>", ignore)
vim.keymap.set("n", "<right>", ":bp<CR>", ignore)
