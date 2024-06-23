-- Add Run command
vim.api.nvim_create_user_command(
  "Run",
  function()
    require("custom.cargo").run()
  end,
  { nargs = 0 }
)

vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4

-- Set tab width to 2 for select files
vim.api.nvim_create_autocmd(
  { "BufEnter", "BufWinEnter" },
  {
    pattern = { "*.gd", "*.nix", "*.lua", "Makefile" },
    callback = function()
      vim.bo.tabstop = 2
      vim.bo.softtabstop = 2
      vim.bo.shiftwidth = 2
    end
  }
)

vim.o.guifont = "FiraCode Nerd Font:h10"
