-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"

local nomap = vim.keymap.del

local on_attach = function(client, bufnr)
  require("nvchad.configs.lspconfig").on_attach(client, bufnr)

  nomap("n", "<leader>wa")
  nomap("n", "<leader>wr")
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
