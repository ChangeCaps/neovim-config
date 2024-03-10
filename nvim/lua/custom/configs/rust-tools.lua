local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local cargo = require("custom.cargo")

local options = {
  server = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)

      vim.api.nvim_buf_create_user_command(
        bufnr,
        "Run",
        function()
            cargo.run()
        end,
        { nargs = 0 }
      )
    end,
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
