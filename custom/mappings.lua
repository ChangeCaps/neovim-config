local M = {}

local nowait = { nowait = true, noremap = true, silent = true }

M.git = {
  n = {
    ["<leader>gg"] = { "<cmd>LazyGit <CR>", "Open LazyGit", opts = nowait },
    ["<leader>gc"] = { "<cmd>LazyGitConfig <CR>", "Open LazyGit Config", opts = nowait },
    ["<leader>gf"] = { "<cmd>LazyGitCurrentFile <CR>", "Open LazyGit Current File", opts = nowait },
    ["<leader>gF"] = { "<cmd>LazyGitFilter <CR>", "Open LazyGit Filter", opts = nowait },
    ["<leader>gC"] = { "<cmd>LazyGitFilterCurrentFile <CR>", "Open LazyGit Filter Current File", opts = nowait },
  },
}

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
    ["K"] = { "<cmd> m -2 <CR>", opts = nowait },
    ["J"] = { "<cmd> m +1 <CR>", opts = nowait },
  },
  v = {
    ["<C-h>"] = { "_", "Move to start of line", opts = nowait },
    ["<C-l>"] = { "$", "Move to end of line", opts = nowait },
    ["<C-k>"] = { "10k", "Move up quick", opts = nowait },
    ["<C-j>"] = { "10j", "Move down quick", opts = nowait },
    ["K"] = { "<cmd>'<,'> m '<-2 <CR> gv==gv", opts = nowait },
    ["J"] = { "<cmd>'<,'> m '>+1 <CR> gv=gv", opts = nowait },
  },
}

M.window = {
  n = {
    ["<leader>h"] = { "<C-w>h", "Move window left", opts = nowait },
    ["<leader>j"] = { "<C-w>j", "Move window down", opts = nowait },
    ["<leader>k"] = { "<C-w>k", "Move window up", opts = nowait },
    ["<leader>l"] = { "<C-w>l", "Move window right", opts = nowait },
    ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "Telescope Files" },
  },
}

M.buffer = {
  n = {
    ["<leader>q"] = { "<cmd> bp <bar> sp <bar> bn <bar> bd <CR>", "Close current buffer", opts = nowait },
  },
}

M.tab = {
  n = {
    ["<leader>tt"] = { "<cmd>tabnew<CR>", "Create new tab", opts = nowait },
    ["<leader>tq"] = { "<cmd>tabclose<CR>", "Close tab", opts = nowait },
  }
}

for i = 1, 9 do
  M.tab.n["<leader>" .. i] = { "<cmd>tabnext " .. i .. "<CR>", "Go to tab " .. i, opts = nowait }
end

local sidebar = nil
M.debug = {
  n = {
    ["<leader>d"] = {
      function()
        require('dap').toggle_breakpoint()
      end,
      "Toggle breakpoint",
    },
    ["<leader>D"] = {
      function()
        require('dap').clear_breakpoints()
      end,
      "Clear breakpoints",
    },
    ["<F4>"] = {
      function()
        require('dap').run_last()
      end,
      "Run last configuration",
    },
    ["<F5>"] = {
      "<cmd> RustDebuggables <CR>",
      "Debug rust",
    },
    ["<F6>"] = {
      function()
        require('dap').continue()
      end,
      "Continue",
    },
    ["<F7>"] = {
      function()
        require('dap').run_to_cursor()
      end,
      "Run to cursor",
    },
    ["<F10>"] = {
      function()
        require('dap').step_over()
      end,
      "Step over",
    },
    ["<F11>"] = {
      function()
        require('dap').step_into()
      end,
      "Step into",
    },
    ["<F12>"] = {
      function()
        require('dap').step_out()
      end,
      "Step out",
    },
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
    },
    ["H"] = {
      function()
        vim.lsp.buf.declaration()
      end
    },
    ["L"] = {
      function()
        vim.lsp.buf.hover()
      end,
    },
  },
}

return M
