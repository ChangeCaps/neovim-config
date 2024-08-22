local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local config = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local dap = require("dap")

dap.adapters.gdb = {
  id = "gdb",
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" },
}

local map = vim.keymap.set

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

local gdb = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return coroutine.create(function(coro)
        local opts = {}
        pickers.new(opts, {
          prompt_title = "Path to executable",
          finder = finders.new_oneshot_job({
            "fd",
            "--no-ignore",
            "--exclude",
            "lute-cache",
            "--type",
            "x",
          }, {}),
          sorter = config.generic_sorter(opts),
          attach_mappings = function(bufnr)
            actions.select_default:replace(function()
              actions.close(bufnr)
              local path = action_state.get_selected_entry()[1]
              coroutine.resume(coro, path)
            end)
            return true
          end,
        }):find()
      end)
    end,
    args = function()
      return coroutine.create(function(coro)
        get_arguments(function(args)
          coroutine.resume(coro, args)
        end)
      end)
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
  },
}

dap.configurations.c = gdb
dap.configurations.cpp = gdb
dap.configurations.rust = gdb
