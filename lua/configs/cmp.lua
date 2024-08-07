local cmp = require("cmp")

local M = require("nvchad.configs.cmp")

M.mapping["<Tab>"] = cmp.mapping(function(fallback)
  if cmp.visible() then
    cmp.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  elseif require("luasnip").expand_or_jumpable() then
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
      "<Plug>luasnip-expand-or-jump",
      true,
      true,
      true
    ), "")
  else
    fallback()
  end
end)

M.mapping["<S-Tab"] = cmp.mapping.select_next_item()
M.mapping["<C-j>"] = cmp.mapping.select_next_item()
M.mapping["<C-k>"] = cmp.mapping.select_prev_item()

table.insert(M.sources, { name = "crates" })

return M
