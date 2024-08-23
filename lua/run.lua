local M = {}

local map = vim.keymap.set

---@param apply fun(args: string)
M.get_arguments = function(apply)
  local win = require("plenary.popup").create("", {
    title = "DAP Arguments",
    style = "minimal",
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    relative = "window",
    borderhighlight = "RenamerBorder",
    titlehighlight = "RenamerTitle",
    focusable = true,
    width = 40,
    height = 1,
  })

  vim.cmd("normal A")
  vim.cmd("startinsert")

  map({ "i", "n"}, "<Esc>", function()
    apply("")
    vim.api.nvim_win_close(win, true)
    vim.cmd.stopinsert()
  end, { buffer = 0 })

  map({ "i", "n"}, "<CR>", function()
    local line = vim.trim(vim.fn.getline("."))
    vim.api.nvim_win_close(win, true)
    vim.cmd.stopinsert()

    apply(line)
  end, { buffer = 0 })
end

return M
