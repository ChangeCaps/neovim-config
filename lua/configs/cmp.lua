local M = require "plugins.configs.cmp"

local complete = M.mapping["<CR>"]
local next = M.mapping["<Tab>"]
local prev = M.mapping["<S-Tab>"]

M.mapping["<Tab>"] = complete
M.mapping["<down>"] = next
M.mapping["<C-j>"] = next
M.mapping["<S-Tab>"] = next
M.mapping["<up>"] = prev
M.mapping["<C-k>"] = prev

table.insert(M.sources, { name = "crates" })

return M
