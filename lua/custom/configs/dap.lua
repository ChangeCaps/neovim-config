local dap = require("dap")
dap.adapters.gdb = {
  id = "gdb",
  type = "executable",
  command = "gdb",
  args = { "--quiet", "--interpreter=dap" },
}

local cxx = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      -- Otherwise, ask the user for the path to the executable
      local path vim.fn.input({
        prompt = "Path to executable: ",
        default = vim.fn.getcwd() .. "/",
        completion = "file",
      })

      return path
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
}

dap.configurations.c = cxx
dap.configurations.cpp = cxx
