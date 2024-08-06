require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<leader>gg", "<cmd>LazyGit <CR>", { desc = "Open LazyGit" })
map("n", "<leader>gc", "<cmd>LazyGitConfig <CR>", { desc = "Open LazyGit Config" })
map("n", "<leader>gf", "<cmd>LazyGitCurrentFile <CR>", { desc = "Open LazyGit Current File" })
map("n", "<leader>gF", "<cmd>LazyGitFilter <CR>", { desc = "Open LazyGit Filter" })
map("n", "<leader>gC", "<cmd>LazyGitFilterCurrentFile <CR>", { desc = "Open LazyGit Filter Current File" })

map("n", "<leader>w", ":w<CR>", { desc = "Save File" })
map("n", "<C-h>", "_", { desc = "Move to start of line" })
map("n", "<C-l>", "$", { desc = "Move to end of line" })
map("n", "<C-k>", "10k", { desc = "Move up quick" })
map("n", "<C-j>", "10j", { desc = "Move down quick" })
map("n", "K", "<cmd> m -2 <CR>")
map("n", "J", "<cmd> m +1 <CR>")

map("v", "<C-h>", "_", { desc = "Move to start of line" })
map("v", "<C-l>", "$", { desc = "Move to end of line" })
map("v", "<C-k>", "10k", { desc = "Move up quick" })
map("v", "<C-j>", "10j", { desc = "Move down quick" })
map("v", "K", "<cmd>'<,'> m '<-2 <CR> gv==gv")
map("v", "J", "<cmd>'<,'> m '>+1 <CR> gv=gv")

map("n", "<leader>h", "<C-w>h", { desc = "Move window left" })
map("n", "<leader>j", "<C-w>j", { desc = "Move window down" })
map("n", "<leader>k", "<C-w>k", { desc = "Move window up" })
map("n", "<leader>l", "<C-w>l", { desc = "Move window right" })
map("n", "<C-p>", "<cmd> Telescope find_files <CR>", { desc = "Telescope Files" })

map("n", "<leader>q", "<cmd> bp <bar> sp <bar> bn <bar> bd <CR>", { desc = "Close current buffer" })

map("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "Create new tab" })
map("n", "<leader>tq", "<cmd>tabclose<CR>", { desc = "Close tab" })

for i = 1, 9 do
  map("n", "<leader>" .. i, "<cmd>tabnext " .. i .. "<CR>", { desc = "Go to tab " .. i })
end


map("n", "<leader>d", function()
  require('dap').toggle_breakpoint()
end, { desc = "Toggle breakpoint" })
map("n", "<leader>D", function()
  require('dap').clear_breakpoints()
end, { desc = "Clear breakpoints" })
map("n", "<F4>", function()
  require('dap').run_last()
end, { desc = "Run last configuration" })
map("n", "<F5>", "<cmd> RustDebuggables <CR>", { desc = "Debug rust" })
map("n", "<F6>", function()
  require('dap').continue()
end, { desc = "Continue" })
map("n", "<F7>", function()
  require('dap').run_to_cursor()
end, { desc = "Run to cursor" })
map("n", "<F10>", function()
  require('dap').step_over()
end, { desc = "Step over" })
map("n", "<F11>", function()
  require('dap').step_into()
end, { desc = "Step into" })
map("n", "<F12>", function()
  require('dap').step_out()
end, { desc = "Step out" })

local sidebar = nil
map("n", "<F8>", function()
  local widgets = require "dap.ui.widgets"

  if sidebar == nil then
    local winopts = {
      width = 50,
    }

    sidebar = widgets.sidebar(widgets.scopes, winopts)
  end

  sidebar.toggle()
end, { desc = "Open debugging sidebar" })


map("n", "<leader>a", function ()
  vim.lsp.buf.code_action()
end, { desc = "LSP code action" })
map("n", "<leader>r", function()
  vim.lsp.buf.rename()
end, { desc = "LSP rename" })
map("n", "H", function()
  vim.lsp.buf.declaration()
end, { desc = "LSP declaration" })
map("n", "L", function()
  vim.lsp.buf.hover()
end, { desc = "LSP hover" })
