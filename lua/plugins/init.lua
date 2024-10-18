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
      on_attach = require 'configs.nvim-tree',
      auto_reload_on_write = true,
      reload_on_bufenter = true,
      view = {
        width = 40,
        preserve_window_proportions = false,
      },
      renderer = {
        group_empty = true,
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
        timeout = 1000,
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      highlight = {
        disable = { "c", "cpp", "rust", "java" },
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local opts = require "configs.telescope"
      require("telescope").setup(opts)
      require("telescope").load_extension("ui-select")
    end,
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
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "configs.gitsigns"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "configs.cmp"
    end
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

  -- nvim-surround
  {
    "kylechui/nvim-surround",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-surround").setup()
    end,
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
