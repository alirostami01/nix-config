return {
  -- 1. mason.nvim
  {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
    build = ":MasonUpdate",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonUpdate",
      "MasonLog",
    },
    opts = {
      ui = {
        border = "rounded",
        height = 0.8,
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
    },
  },

  -- 2. mason-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "ts_ls",
        "cssls",
        "pyright",
        "dockerls",
        "tailwindcss",
        "jsonls",
      },
      automatic_installation = true,
    },
  },

  -- 3. mason-nvim-lint
  {
    "rshkarin/mason-nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-lint",
    },
    opts = {
      ensure_installed = {},
      automatic_installation = true,
      quiet_mode = false,
    },
  },
}
