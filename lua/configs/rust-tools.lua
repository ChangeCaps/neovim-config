local capabilities = require("nvchad.configs.lspconfig").capabilities

local map = vim.keymap.set
local nomap = vim.keymap.del

local on_attach = function(client, bufnr)
  require("nvchad.configs.lspconfig").on_attach(client, bufnr)

  map("n", "<leader>a", function()
    vim.lsp.buf.code_action()
  end, { desc = "LSP code action", buffer = bufnr })
  map("n", "<leader>r", function()
    require("nvchad.lsp.renamer")()
  end, { desc = "LSP rename", buffer = bufnr })
  map("n", "H", function()
    vim.lsp.buf.declaration()
  end, { desc = "LSP declaration", buffer = bufnr })
  map("n", "L", function()
    vim.lsp.buf.hover()
  end, { desc = "LSP hover", buffer = bufnr })

  nomap("n", "<leader>wa", { buffer = bufnr })
  nomap("n", "<leader>wr", { buffer = bufnr })
  nomap("n", "<leader>ra", { buffer = bufnr })
end

local options = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}

return options
