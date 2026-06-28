return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local theme = require("tokyonight")
    theme.setup({
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },

    })
    vim.cmd([[colorscheme tokyonight]])
  end,
}
