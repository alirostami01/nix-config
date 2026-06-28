return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.g.deprecation_warnings = false

    local nvlsp = require "nvchad.configs.lspconfig"

    local on_attach = nvlsp.on_attach
    local on_init = nvlsp.on_init
    local capabilities = nvlsp.capabilities

    local servers = { "html", "cssls", "ts_ls", "tailwindcss", "prismals", "jsonls", "gopls" }

    for _, lsp in ipairs(servers) do
      vim.lsp.config(lsp, {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
      })
      vim.lsp.enable(lsp)
    end

    vim.lsp.config("lua_ls", {
      on_attach = on_attach,
      on_init = on_init,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      },
    })
    vim.lsp.enable "lua_ls"
  end,
}
