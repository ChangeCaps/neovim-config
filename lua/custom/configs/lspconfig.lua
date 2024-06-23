local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"

-- format on save
vim.api.nvim_create_autocmd(
  { "BufWritePre" },
  {
    pattern = "*",
    callback = function()
      vim.lsp.buf.format()
    end
  }
)

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

-- html
lspconfig.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- python
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- css
lspconfig.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- godot
lspconfig.gdscript.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- javascript
lspconfig.tsserver.setup({
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
