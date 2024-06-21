-- Add Run command
vim.api.nvim_create_user_command(
  "Run",
  function()
    require("custom.cargo").run()
  end,
  { nargs = 0 }
)

-- Set tab width to 4 for godot scripts
vim.api.nvim_create_autocmd(
  { "BufEnter" },
  {
    command =  "echo asghjkfdsfg",
  }
)

vim.o.guifont = "FiraCode Nerd Font:h10"
