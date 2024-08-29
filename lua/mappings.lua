require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("v", ";", ":", { desc = "CMD enter command mode" })

-- Exit terminal mode
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Terminal quit" })

map("n", "<leader>tm", function()
  local prev_buf = vim.api.nvim_get_current_buf()

  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_win_set_buf(win, buf)

  local function quit()
    vim.api.nvim_win_set_buf(win, prev_buf)
    vim.api.nvim_buf_delete(buf, { force = true })
  end

  map("n", "q", quit, { buffer = buf })
  map("n", "<Esc>", quit, { buffer = buf })

  vim.fn.termopen("$SHELL")
  vim.api.nvim_input("a")
end, { desc = "Terminal open temporary" })

nomap("n", "<leader>wk")
nomap("n", "<leader>wK")
nomap("n", "<leader>rn")
nomap("n", "<leader>ds")

local function laygitcmd(command)
  return function()
    vim.api.nvim_command(command);

    local buf = vim.api.nvim_get_current_buf()
    map("t", "<Esc>", "<Esc>", { buffer = buf })
  end
end

-- LazyGit 
map("n", "<leader>gg", laygitcmd("LazyGit"), {
  desc = "LazyGit Open"
})
map("n", "<leader>gc", "<cmd>LazyGitConfig <CR>",{
  desc = "LazyGit Open Config"
})
map("n", "<leader>gf", laygitcmd("LazyGitFiles"), {
  desc = "LazyGit Open Current File"
})
map("n", "<leader>gF", laygitcmd("LazyGitFilesAll"), {
  desc = "LazyGit Open Filter"
})
map("n", "<leader>gC", laygitcmd("LazyGitFilesCurrent"), {
  desc = "LazyGit Open Filter Current File"
})

map("n", "<leader>w", function()
  if vim.bo.modified then
    vim.api.nvim_command('w')
  end
end, { desc = "Buffer save" })
map("n", "<C-h>", "_", { desc = "Move start of line" })
map("n", "<C-l>", "$", { desc = "Move end of line" })
map("n", "<C-k>", "10k", { desc = "Move up quick" })
map("n", "<C-j>", "10j", { desc = "Move down quick" })
map("n", "K", "<cmd> m -2 <CR>", { desc = "Move line up" })
map("n", "J", "<cmd> m +1 <CR>", { desc = "Move line down" })

map("v", "<C-h>", "_", { desc = "Move start of line" })
map("v", "<C-l>", "$", { desc = "Move end of line" })
map("v", "<C-k>", "10k", { desc = "Move up quick" })
map("v", "<C-j>", "10j", { desc = "Move down quick" })

map("n", "<leader>h", "<C-w>h", { desc = "Move window left" })
map("n", "<leader>j", "<C-w>j", { desc = "Move window down" })
map("n", "<leader>k", "<C-w>k", { desc = "Move window up" })
map("n", "<leader>l", "<C-w>l", { desc = "Move window right" })
map("n", "<C-p>", "<cmd> Telescope find_files <CR>", { desc = "Telescope find files" })

map("n", "<leader>q", "<cmd> bp <bar> sp <bar> bn <bar> bd <CR>", { desc = "Buffer close" })

map("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "Tab new" })
map("n", "<leader>tq", "<cmd>tabclose<CR>", { desc = "Tab close" })

for i = 1, 9 do
  map("n", "<leader>" .. i, "<cmd>tabnext " .. i .. "<CR>", { desc = "Tab go to " .. i })
end

-- LSP
map("n", "<leader>a", function()
  vim.lsp.buf.code_action()
end, { desc = "LSP code action" })
map("n", "<leader>r", function()
  require("nvchad.lsp.renamer")()
end, { desc = "LSP rename" })
map("n", "H", function()
  vim.lsp.buf.declaration()
end, { desc = "LSP declaration" })
map("n", "L", function()
  vim.lsp.buf.hover()
end, { desc = "LSP hover" })

map("n", "<leader>fd", function()
  require("telescope.builtin").diagnostics()
end, { desc = "Telescope lsp diagnostics" })

map("n", "<leader>fs", function()
  require("telescope.builtin").lsp_dynamic_workspace_symbols()
end, { desc = "Telescope lsp workspace symbols" })

map("n", "<leader>fr", function()
  require("telescope.builtin").lsp_references()
end, { desc = "Telescope lsp references" })

-- Folding
map("n", "<S-space>", 'za', { desc = "Toggle fold under cursor" })
map("n", "<C-space>", 'zA', { desc = "Toggle all folds under cursor" })

-- Debugging
map("n", "<leader>d", function()
  require('dap').toggle_breakpoint()
end, { desc = "Debug toggle breakpoint" })

map("n", "<leader>dd", function()
  require('dap').clear_breakpoints()
end, { desc = "Debug clear breakpoints" })

map("n", "<F4>", function()
  require('dap').run_last()
end, { desc = "Debug run last configuration" })

map("n", "<F6>", function()
  require('dap').run_to_cursor()
end, { desc = "Debug run to cursor" })

map("n", "<F9>", function()
  require('dap').step_over()
end, { desc = "Debug step over" })

map("n", "<F10>", function()
  require('dap').step_into()
end, { desc = "Debug step into" })

map("n", "<F11>", function()
  require('dap').step_out()
end, { desc = "Debug step out" })

map("n", "<F12>", function()
  require('dap').step_into({ askForTargets = true })
end, { desc = "Debug step into target" })

local sidebar = nil
map("n", "<F8>", function()
  local widgets = require("dap.ui.widgets")

  if sidebar == nil then
    local winopts = {
      width = 50,
    }

    sidebar = widgets.sidebar(widgets.scopes, winopts)
  end

  sidebar.toggle()
end, { desc = "Debug Open sidebar" })

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local config = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function get_executable(apply)
  local opts = {}
  pickers.new(opts, {
    prompt_title = "Path to executable",
    finder = finders.new_oneshot_job({
      "fd",
      "--no-ignore",
      "--exclude",
      "lute-cache",
      "--exclude",
      "target/*/build",
      "--exclude",
      "target/*/deps",
      "--exclude",
      "*.so",
      "--type",
      "x",
    }, {}),
    sorter = config.generic_sorter(opts),
    attach_mappings = function(bufnr)
      actions.select_default:replace(function()
        actions.close(bufnr)
        local path = action_state.get_selected_entry()[1]
        apply(path)
      end)
      return true
    end,
  }):find()
end

map("n", "<F5>", function()
  local dap = require('dap')
  local run = require('run')

  if dap.session() then
    dap.continue()
    return
  end

  local type = "gdb"

  if vim.bo.filetype == "rust" then
    type = "rust-gdb"
  end

  get_executable(function(exec)
    run.get_arguments(function(args)
      dap.run({
        name = "Launch",
        request = "launch",
        type = type,
        program = exec,
        args = args,
        cwd = "${workspaceFolder}",
        stopAtEntry = true,
      })
    end)
  end)
end, { desc = "Debug continue" })
