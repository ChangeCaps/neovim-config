local capabilities = require("nvchad.configs.lspconfig").capabilities

local nomap = vim.keymap.del
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  require("nvchad.configs.lspconfig").on_attach(client, bufnr)

  nomap("n", "<leader>wa", { buffer = bufnr })
  nomap("n", "<leader>wr", { buffer = bufnr })
  nomap("n", "<leader>ra", { buffer = bufnr })

  vim.print("Formatting enabled for " .. client.name)

  vim.api.nvim_clear_autocmds({
      group = augroup,
      buffer = bufnr,
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      if client.supports_method("textDocument/formatting") then
        vim.lsp.buf.format({ bufnr = bufnr })
      end
    end,
  })
end

vim.lsp.config("*", {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.diagnostic.config({
  virtual_text = true,
})

vim.diagnostic.enable()

-- java
vim.lsp.enable("jdtls")

-- c/c++
vim.lsp.enable("clangd")

-- rust
vim.lsp.config("rust_analyzer", {
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

vim.lsp.enable("rust_analyzer")

-- gleam
vim.lsp.enable("gleam")

-- python
vim.lsp.enable("pyright")

-- godot
vim.lsp.enable("gdscript")

-- haskell
vim.lsp.enable("hls")

-- ocaml
vim.lsp.enable("ocamllsp")

-- javascript
vim.lsp.enable("ts_ls")

-- nushell
vim.lsp.enable("nushell")

-- nix
vim.lsp.enable("nixd")

-- zig
vim.lsp.enable("zls")

-- dart
vim.lsp.enable("dartls")

-- typst
vim.lsp.enable("tinymist")

-- ike
vim.lsp.config("ike", {
  cmd = { "ike", "lsp" },
  filetypes = { "ike" },
  root_markers = { ".git" },
  on_attach = on_attach,
  on_init = function() end,
  capabilities = capabilities,
})

vim.lsp.enable("ike")
