local dap = require("dap")

dap.adapters.gdb = {
  id = "gdb",
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" },
}

dap.adapters['rust-gdb'] = {
  id = "rust-gdb",
  type = "executable",
  command = "rust-gdb",
  args = { "-i", "dap" },
}
