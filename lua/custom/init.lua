-- Add Run command
vim.api.nvim_create_user_command(
  "Run",
  function()
    require("custom.cargo").run()
  end,
  { nargs = 0 }
)

vim.o.guifont = "FiraCode Nerd Font:h10"
