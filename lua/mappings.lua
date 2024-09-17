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

-- Use visual lines for jk
map("n", "j", "gj")
map("n", "k", "gk")
map("v", "j", "gj")
map("v", "k", "gk")

map("n", "<C-h>", "g^", { desc = "Move start of visual line" })
map("n", "<C-l>", "g$", { desc = "Move end of visual line" })
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

-- switch to last buffer
map("n", "<leader><leader>", "<C-^>", { desc = "Move switch to last buffer" })

-- window resizing
map("n", "<CS-h>", "<cmd>vertical resize -2<CR>", { desc = "Window resize left" })
map("n", "<CS-j>", "<cmd>resize +2<CR>", { desc = "Window resize down" })
map("n", "<CS-k>", "<cmd>resize -2<CR>", { desc = "Window resize up" })
map("n", "<CS-l>", "<cmd>vertical resize +2<CR>", { desc = "Window resize right" })

-- tabs
map("n", "<leader>q", "<cmd> bp <bar> sp <bar> bn <bar> bd <CR>", { desc = "Buffer close" })
map("n", "<leader>Q", "<cmd> %bd <bar> e# <CR>", { desc = "Buffer close all" })

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
end, { desc = "telescope lsp diagnostics" })

map("n", "<leader>ff", function()
  require("telescope.builtin").lsp_document_symbols()
end, { desc = "telescope lsp document symbols" })

map("n", "<leader>fF", function()
  require("telescope.builtin").lsp_dynamic_workspace_symbols()
end, { desc = "telescope lsp workspace symbols" })

map("n", "<leader>fr", function()
  require("telescope.builtin").lsp_references()
end, { desc = "telescope lsp references" })

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

-- toggle repl
map("n", "<F7>", function()
  require('dap').repl.toggle()
end, { desc = "Debug toggle repl" })

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
local make_entry = require("telescope.make_entry")
local config = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function edit_registers(opts)
  local registers_table = { '"', "-", "#", "=", "/", "*", "+", ":", ".", "%" }

  -- named
  for i = 0, 9 do
    table.insert(registers_table, tostring(i))
  end

  -- alphabetical
  for i = 97, 122 do
    table.insert(registers_table, string.char(i))
  end

  pickers
    .new(opts, {
      prompt_title = "Registers",
      finder = finders.new_table {
        results = registers_table,
        entry_maker = opts.entry_maker or make_entry.gen_from_registers(opts),
      },
      sorter = config.generic_sorter(opts),
      attach_mappings = function(_)
        actions.select_default:replace(function(prompt_bufnr)
          local entry = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          local prev_buf = vim.api.nvim_get_current_buf()

          local win = vim.api.nvim_get_current_win()
          local buf = vim.api.nvim_create_buf(false, true)

          vim.api.nvim_win_set_buf(win, buf)

          -- Set the filetype of the buffer to lua
          vim.api.nvim_set_option_value("filetype", "lua", { buf = buf })

          local reg = vim.fn.getreg(entry.value)

          if reg:sub(-1) == "\n" then
            reg = reg:sub(1, -2)
          end

          reg = reg:gsub("\n", "<CR>")

          vim.api.nvim_input("i" .. reg .. "<Esc>")

          -- Save the content of the buffer to the register
          local function save()
            local content = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
            vim.fn.setreg(entry.value, content)
          end

          -- Create auto commands to save the content of the buffer to the register
          vim.api.nvim_create_autocmd("BufLeave", {
            callback = save,
            once = true,
          })

          map("n", "<Esc>", function()
            vim.api.nvim_win_set_buf(win, prev_buf)
            vim.api.nvim_buf_delete(buf, { force = true })
          end, { buffer = buf })
        end)

        return true
      end,
    })
    :find()
end

map("n", "<leader>fq", function()
  edit_registers({})
end, { desc = "telescope edit registers" })

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
