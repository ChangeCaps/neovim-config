local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local config = require("telescope.config").values
local actions = require("telescope.actions")

local dap = require("dap")

dap.adapters.gdb = {
  id = "gdb",
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" },
}

local cxx = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return coroutine.create(function(coro)
        local opts = {}
        pickers.new(opts, {
          prompt_title = "Path to executable",
          finder = finders.new_oneshot_job({ "fd", "--hidden", "--no-ignore", "--type", "x" }, {}),
          sorter = config.generic_sorter(opts),
          attach_mappings = function(bufnr)
            actions.select_default:replace(function()
              actions.close(bufnr)
              coroutine.resume(coro, actions.state.get_selected_entry()[1])
            end)
            return true
          end,
        }):find()
      end)
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
  },
}

dap.configurations.c = cxx
dap.configurations.cpp = cxx
