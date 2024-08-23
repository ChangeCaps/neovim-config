-- Add Commands
local function check()
  require("cargo").check()
end

local function build()
  require("cargo").build()
end

local function build_last()
  require("cargo").build_last()
end

local function run()
  require("cargo").run()
end

local function run_last()
  require("cargo").run_last()
end

local function create_command(name, fn)
  vim.api.nvim_create_user_command(name, fn, { nargs = 0 })
end

create_command("Check", check)
create_command("C", check)

create_command("Build", build)
create_command("B", build_last)

create_command("Run", run)
create_command("R", run_last)

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

vim.o.guifont = "FiraCode Nerd Font:h10:#e-subpixelantialias"
