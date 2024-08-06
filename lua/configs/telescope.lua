local M = {}

M.defaults = {
  mappings = {
    i = {
      ["<C-j>"] = "move_selection_next",
      ["<C-k>"] = "move_selection_previous",
    }
  }
}

table.insert(M.extensions_list, "ui-select")

return M
