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

dap.adapters.godot = {
  type = "server",
  host = "127.0.0.1",
  port = 6006,
}

dap.configurations.gdscript = {
  {
    type = "godot",
    request = "launch",
    name = "Launch scene",
    project = "${workspaceFolder}",
    scene = "current"
  },
}
