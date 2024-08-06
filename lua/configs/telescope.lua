local M = {}

M.defaults = {
  mappings = {
    i = {
      ["<C-j>"] = "move_selection_next",
      ["<C-k>"] = "move_selection_previous",
    }
  }
}

M.extensions = {
  ["ui-select"] = {}
}

return M
