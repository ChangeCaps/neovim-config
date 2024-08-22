-- Add Commands
local function build()
  require("cargo").build()
end

local function run()
  require("cargo").run()
end

vim.api.nvim_create_user_command(
  "Build",
  build,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  "B",
  build,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  "Run",
  run,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  "R",
  run,
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
