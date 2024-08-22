local capabilities = require("nvchad.configs.lspconfig").capabilities

local nomap = vim.keymap.del

local on_attach = function(client, bufnr)
  require("nvchad.configs.lspconfig").on_attach(client, bufnr)

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
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
        },
      },
    },
  },
}

return options
