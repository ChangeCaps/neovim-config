-- Add Run command
vim.api.nvim_create_user_command(
  "Run",
  function()
    require("custom.cargo").run()
  end,
  { nargs = 0 }
)

vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_scale_factor = 0.8
