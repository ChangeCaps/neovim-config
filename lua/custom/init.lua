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
  { "BufEnter", "BufWinEnter" },
  {
    pattern = { "*.gd" },
    callback = function()
      vim.bo.tabstop = 4
      vim.bo.softtabstop = 4
    end
  }
)

vim.o.guifont = "FiraCode Nerd Font:h10"
