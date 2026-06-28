return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },
			css = { "prettierd" },
			json = { "prettierd" },
			html = { "prettierd" },
		},
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 500,
		},
		notify_on_error = true,
	},
}
