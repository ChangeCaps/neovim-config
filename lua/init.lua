-- Add Run command
vim.api.nvim_create_user_command(
  "Run",
  function()
    require("cargo").run()
  end,
  { nargs = 0 }
)

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Set relative line numbers
vim.opt.relativenumber = true

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
