if not vim.g.neovide then return end

local base46 = require("base46")
local colors = base46.get_theme_tb "base_16"

vim.o.guifont = "FiraCode Nerd Font:h12:#e-subpixelantialias"

local term = {
  "base01",
  "base08",
  "base0B",
  "base0A",
  "base0D",
  "base0E",
  "base0C",
  "base05",
  "base03",
  "base08",
  "base0B",
  "base0A",
  "base0D",
  "base0E",
  "base0C",
  "base07",
}

for i = 0, 15 do
  vim.g["terminal_color_" .. i] = colors[term[i + 1]]
end
