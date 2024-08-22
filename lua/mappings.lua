require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })

nomap("n", "<leader>wk")
nomap("n", "<leader>wK")
nomap("n", "<leader>rn")

-- LazyGit 
map("n", "<leader>gg", "<cmd>LazyGit <CR>", {
  desc = "LazyGit Open"
})
map("n", "<leader>gc", "<cmd>LazyGitConfig <CR>", {
  desc = "LazyGit Open Config"
})
map("n", "<leader>gf", "<cmd>LazyGitCurrentFile <CR>", {
  desc = "LazyGit Open Current File"
})
map("n", "<leader>gF", "<cmd>LazyGitFilter <CR>", {
  desc = "LazyGit Open Filter"
})
map("n", "<leader>gC", "<cmd>LazyGitFilterCurrentFile <CR>", {
  desc = "LazyGit Open Filter Current File"
})

map("n", "<leader>w", function()
  vim.api.nvim_command('w')
end, { desc = "Save file" })
map("n", "<C-h>", "_", { desc = "Move start of line" })
map("n", "<C-l>", "$", { desc = "Move end of line" })
map("n", "<C-k>", "10k", { desc = "Move up quick" })
map("n", "<C-j>", "10j", { desc = "Move down quick" })
map("n", "K", "<cmd> m -2 <CR>")
map("n", "J", "<cmd> m +1 <CR>")

map("v", "<C-h>", "_", { desc = "Move start of line" })
map("v", "<C-l>", "$", { desc = "Move end of line" })
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


-- Debugging
map("n", "<leader>d", function()
  require('dap').toggle_breakpoint()
end, { desc = "Debug Toggle breakpoint" })

map("n", "<leader>dd", function()
  require('dap').clear_breakpoints()
end, { desc = "Debug Clear breakpoints" })

map("n", "<F4>", function()
  require('dap').run_last()
end, { desc = "Debug Run last configuration" })

map("n", "<F6>", function()
  require('dap').run_to_cursor()
end, { desc = "Debug Run to cursor" })

map("n", "<F9>", function()
  require('dap').step_over()
end, { desc = "Debug Step over" })

map("n", "<F10>", function()
  require('dap').step_into()
end, { desc = "Debug Step into" })

map("n", "<F11>", function()
  require('dap').step_out()
end, { desc = "Debug Step out" })

map("n", "<F12>", function()
  require('dap').step_into({ askForTargets = true })
end, { desc = "Debug Step into target" })

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

local function get_arguments(apply)
  local win = require("plenary.popup").create("", {
    title = "DAP Arguments",
    style = "minimal",
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    relative = "window",
    borderhighlight = "RenamerBorder",
    titlehighlight = "RenamerTitle",
    focusable = true,
    width = 40,
    height = 1,
  })

  vim.cmd("normal A")
  vim.cmd("startinsert")

  map({ "i", "n"}, "<Esc>", function()
    apply("")
    vim.api.nvim_win_close(win, true)
    vim.cmd.stopinsert()
  end, { buffer = 0 })

  map({ "i", "n"}, "<CR>", function()
    local line = vim.trim(vim.fn.getline("."))
    vim.api.nvim_win_close(win, true)
    vim.cmd.stopinsert()

    apply(line)
  end, { buffer = 0 })
end

map("n", "<F5>", function()
  local dap = require('dap')

  if dap.session() then
    dap.continue()
    return
  end

  local type = "gdb"

  if vim.bo.filetype == "rust" then
    type = "rust-gdb"
  end

  get_executable(function(exec)
    get_arguments(function(args)
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
end, { desc = "Debug Continue" })
