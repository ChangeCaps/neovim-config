-- Add Commands
local function check()
  require("cargo").check()
end

local function test(opts)
  local test_opts = {}

  for _, v in ipairs(opts.fargs) do
    if v == "all" or v == "a" then
      test_opts.all = true
    end
  end

  require("cargo").test(test_opts)
end

local function build()
  require("cargo").build()
end

local function build_last()
  require("cargo").build_last()
end

local function run(opts)
  local run_opts = {}

  for _, v in ipairs(opts.fargs) do
    if v == "release" or v == "r" then
      run_opts.release = true
    end
  end

  require("cargo").run(run_opts)
end

local function run_last(opts)
  if #opts.fargs > 0 then
    run(opts)
  else
    require("cargo").run_last()
  end
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
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

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
