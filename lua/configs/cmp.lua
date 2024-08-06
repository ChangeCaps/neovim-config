local cmp = require("cmp")

local M = {}

M.mapping = {
  ["<Tab>"] = cmp.mapping.complete(),
  ["<S-Tab"] = cmp.mapping.select_next_item(),
  ["<C-j>"] = cmp.mapping.select_next_item(),
  ["<C-k>"] = cmp.mapping.select_prev_item(),
}

M.sources = {
  { name = "crates" },
}

return M
