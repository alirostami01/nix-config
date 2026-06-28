return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local treesitter = require "nvim-treesitter.configs"

    treesitter.setup {
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = {},
      },
      ensure_installed = {
        "markdown_inline",
        "markdown",
        "tsx",
        "toml",
        "fish",
        "json",
        "yaml",
        "css",
        "html",
        "lua",
        "javascript",
        "typescript",
        "go",
      },
      auto_install = true,
    }
  end,
}
