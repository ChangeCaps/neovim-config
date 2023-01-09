local ignore = { noremap = true, silent = true }
local silent = { silent = true }

-- Vimspector
vim.keymap.set("n", "<F5>", "<cmd>call vimspector#Continue()<CR>")
vim.keymap.set("n", "<F8>", "<cmd>call vimspector#ToggleBreakpoint()<CR>")
vim.keymap.set("n", "<F9>", "<cmd>call vimspector#Launch()<CR>")
vim.keymap.set("n", "<F10>", "<cmd>call vimspector#StepInto()<CR>")
vim.keymap.set("n", "<F11>", "<cmd>call vimspector#StepOver()<CR>")
vim.keymap.set("n", "<F12>", "<cmd>call vimspector#StepOut()<CR>")

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
