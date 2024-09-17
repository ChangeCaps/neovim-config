-- Add Commands
local function check()
  if vim.bo.filetype == "rust" then
    return require("cargo").check()
  end

  vim.notify("Check is not supported for this filetype")
end

local function test(opts)
  if vim.bo.filetype == "rust" then
    return require("cargo").test(opts)
  end

  vim.notify("Test is not supported for this filetype")
end

local function build(opts)
  if vim.bo.filetype == "rust" then
    return require("cargo").build(opts)
  end

  vim.notify("Build is not supported for this filetype")
end

local function build_last(opts)
  if vim.bo.filetype == "rust" then
    return require("cargo").build_last(opts)
  end

  vim.notify("Build last is not supported for this filetype")
end

local function run(opts)
  if vim.bo.filetype == "rust" then
    return require("cargo").run(opts)
  end

  vim.notify("Run is not supported for this filetype")
end

local function run_last(opts)
  if vim.bo.filetype == "rust" then
    return require("cargo").run_last(opts)
  end

  vim.notify("Run last is not supported for this filetype")
end

local function create_command(name, fn)
  vim.api.nvim_create_user_command(name, fn, { nargs = "*" })
end

create_command("Check", check)
create_command("C", check)

create_command("Test", test)
create_command("T", test)

create_command("Build", build)
create_command("B", build_last)

create_command("Run", run)
create_command("R", run_last)

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Set foldings
vim.opt.foldmethod = "indent"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

-- Set relative line numbers
vim.opt.relativenumber = true

-- Set tab width to 2 for select files
vim.api.nvim_create_autocmd(
  { "BufReadPost", "BufNewFile" },
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
