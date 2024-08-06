local M = require("nvchad.configs.gitsigns")

local nvchad_on_attach = M.on_attach
M.on_attach = function(bufnr)
  nvchad_on_attach(bufnr)

  local nomap = vim.keymap.del

  nomap("n", "<leader>rh")
end

return M
