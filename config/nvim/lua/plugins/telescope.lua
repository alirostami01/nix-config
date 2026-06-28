return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local fb_actions = require("telescope").extensions.file_browser.actions

		local keymap = vim.keymap.set
		local opts = { noremap = true, silent = true }

		keymap("n", "sf", builtin.find_files, opts)
		keymap("n", "fw", builtin.live_grep, opts)

		telescope.setup({
			defaults = {
				mappings = {
					n = {
						["q"] = actions.close,
					},
				},
			},
			extensions = {
				file_browser = {
					theme = "dropdown",
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
					mappings = {
						-- your custom insert mode mappings
						["i"] = {
							["<C-w>"] = function()
								vim.cmd("normal vbd")
							end,
						},
						["n"] = {
							-- your custom normal mode mappings
							["a"] = fb_actions.create,
							["d"] = fb_actions.remove,
							["r"] = fb_actions.rename,
							["c"] = fb_actions.copy,
							["h"] = fb_actions.goto_parent_dir,
							["/"] = function()
								vim.cmd("startinsert")
							end,
						},
					},
				},
			},
		})
	end,
}
