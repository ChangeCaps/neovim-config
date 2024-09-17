-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"

local nomap = vim.keymap.del

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  require("nvchad.configs.lspconfig").on_attach(client, bufnr)

  nomap("n", "<leader>wa", { buffer = bufnr })
  nomap("n", "<leader>wr", { buffer = bufnr })
  nomap("n", "<leader>ra", { buffer = bufnr })

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

-- java
lspconfig.jdtls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

-- c/c++
lspconfig.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- rust
lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
      cargo = {
        features = "all",
        allTargets = true,
        loadOutDirsFromCheck = true,
      },
      workspace = {
        symbol = {
          search = {
            kind = "all_symbols",
          },
        },
      },
      rustfmt = {
        extraArgs = { "+nightly" },
      },
    },
  },
})

-- gleam
lspconfig.gleam.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- python
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- godot
lspconfig.gdscript.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- javascript
lspconfig.ts_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- nix
lspconfig.nixd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- zig
lspconfig.zls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("build.zig", ".git"),
})
