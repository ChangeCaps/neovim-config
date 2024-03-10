vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.api.nvim_create_autocmd("TermClose", {
  pattern = "*",
  callback = function()
    -- only close the terminal if isn't in a floating window
    local win = vim.api.nvim_get_current_win()
    local config = vim.api.nvim_win_get_config(win)

    print(vim.inspect(config))

    if config.relative == "" and not config.external then
        vim.cmd("bp | sp | bn | bd")
    end
  end,
})
