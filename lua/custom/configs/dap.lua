local dap = require("dap")
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" },
  name = "gdb",
}

local cxx = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      -- If we have a Makefile, use it to find the executable
      if vim.fn.filereadable("Makefile") == 1 then
        --return "make run"
      end

      -- Otherwise, ask the user for the path to the executable
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
}

dap.configurations.c = cxx
dap.configurations.cpp = cxx
