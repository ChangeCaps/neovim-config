return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      on_attach = require 'config.nvim-tree',
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
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.none-ls"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = require "configs.telescope",
    lazy = false,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = false,
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "configs.cmp"
    end
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
      return require "configs.rust-tools"
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
    config = function()
      return require "configs.dap"
    end,
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
    "catppuccin/nvim",
    priority = 1000,
    lazy = false,
    config = function()
      local catppuccin = require("catppuccin")
      catppuccin.setup({
        term_colors = true,
      })

      vim.cmd.colorscheme "catppuccin"
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
    "ziglang/zig.vim",
    ft = { "zig" },
  },
  {
    "DingDean/wgsl.vim",
    ft = "wgsl",
  },
  {
    -- glsl
    "tikhomirov/vim-glsl",
    ft = { "glsl", "vert", "frag" },
  }
}
