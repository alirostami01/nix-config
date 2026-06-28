return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	event = { "VimEnter", "BufReadPost", "BufNewFile" },
	keys = {
		{ "t", ":Neotree toggle<CR>", desc = "" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		{
			"s1n7ax/nvim-window-picker",
			name = "window-picker",
			event = "VeryLazy",
			version = "2.*",
			config = function()
				require("window-picker").setup()
			end,
		},
	},
	opts = {
		window = {
			width = 30,
		},
	},
}
