-- Add Run command
vim.api.nvim_create_user_command(
  "Run",
  function()
    require("custom.cargo").run()
  end,
  { nargs = 0 }
)

local copyright = [[
// Copyright (C) %year%  %author%
// See end of file for license information.
]]

local agpl = [[
// This file is part of %project%.
// Copyright (C) %year%  %author%
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]

vim.api.nvim_create_user_command(
  "AGPL",
  function()
    local year = os.date("%Y")
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
