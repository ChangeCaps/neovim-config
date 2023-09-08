local plugins = {
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      on_attach = require 'custom.nvim-tree',
      auto_reload_on_write = true,
      reload_on_bufenter = true,
      view = {
        width = 40,
        preserve_window_proportions = false,
      },
      renderer = {
        icons = {
          show = {
            git = true,
          },
        },
      },
      update_focused_file = {
        enable = false,
      },
      filesystem_watchers = {
        enable = false,
      },
      git = {
        enable = true,
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = require "custom.configs.telescope",
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "custom.configs.cmp"
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },
  {
    "ionide/Ionide-vim",
    ft = "fsharp",
  },
  {
    "godlygeek/tabular",
    lazy = false,
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "saecki/crates.nvim",
    dependencies = "hrsh7th/nvim-cmp",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require "crates"
      crates.setup(opts)
      crates.show()
    end
  },
  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<S-CR>",
        },
      }
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },
  {
    "DingDean/wgsl.vim",
    ft = "wgsl",
  },
}

return plugins
