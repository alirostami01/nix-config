return {
	"nvimdev/lspsaga.nvim",
	config = function()
		local lspsaga = require("lspsaga")
		lspsaga.setup({})

		local keymap = vim.keymap.set
		local opts = { noremap = true, silent = true }

		keymap("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
		keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
		keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
		keymap("n", "<C-f>", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	end,
}
