local M = {}

local nowait = { nowait = true, noremap = true, silent = true }

M.disabled = {
  n = {
    ["<leader>ls"] = "",
    ["<leader>rn"] = "",
    ["<leader>ra"] = "",
    ["<leader>rh"] = "",
    ["<leader>wa"] = "",
    ["<leader>wr"] = "",
    ["<leader>wl"] = "",
    ["<leader>wk"] = "",
    ["<leader>wK"] = "",
  },
  i = {
    ["<S-space>"] = "",
  },
}

M.edit = {
  n = {
    ["<leader>w"] = { ":w<CR>", "Save File", opts = nowait },
    ["<C-h>"] = { "_", "Move to start of line", opts = nowait },
    ["<C-l>"] = { "$", "Move to end of line", opts = nowait },
    ["<C-k>"] = { "10k", "Move up quick", opts = nowait },
    ["<C-j>"] = { "10j", "Move down quick", opts = nowait },
  },
  v = {
    ["<C-h>"] = { "_", "Move to start of line", opts = nowait },
    ["<C-l>"] = { "$", "Move to end of line", opts = nowait },
    ["<C-k>"] = { "10k", "Move up quick", opts = nowait },
    ["<C-j>"] = { "10j", "Move down quick", opts = nowait },
  },
}

M.window = {
  n = {
    ["<leader>h"] = { "<C-w>h", "Move window left", opts = nowait },
    ["<leader>j"] = { "<C-w>j", "Move window down", opts = nowait },
    ["<leader>k"] = { "<C-w>k", "Move window up", opts = nowait },
    ["<leader>l"] = { "<C-w>l", "Move window right", opts = nowait },
    ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "Telescope Files" }
  },
}

local sidebar = nil
M.debug = {
  n = {
    ["<leader>d"] = { "<cmd> DapToggleBreakpoint <CR>", "Toggle breakpoint" },
    ["<F5>"] = { "<cmd> RustDebuggables <CR>", "Debug rust" },
    ["<F10>"] = { "<cmd> DapStepOver <CR>", "Step over" },
    ["<F11>"] = { "<cmd> DapStepInto <CR>", "Step into" },
    ["<F12>"] = { "<cmd> DapStepOut <CR>", "Step out" },
    ["<F8>"] = {
      function()
        local widgets = require "dap.ui.widgets"

        if sidebar == nil then
          local winopts = {
            width = 50,
          }

          sidebar = widgets.sidebar(widgets.scopes, winopts)
        end

        sidebar.toggle()
      end,
      "Open debugging sidebar",
    },
  },
}


M.lspconfig = {
  n = {
    ["<leader>a"] = {
      function ()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
    ["<leader>r"] = {
      function()
        vim.lsp.buf.rename()
      end,
      "LSP rename",
      opts = nowait,
    }
  },
}

return M
