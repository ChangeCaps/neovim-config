local M = require "plugins.configs.telescope"

M.defaults.mappings.i = {
  ["<C-j>"] = "move_selection_next",
  ["<C-k>"] = "move_selection_previous",
}

return M
