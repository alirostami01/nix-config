local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.api.nvim_set_var("mapleader", " ")

map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "<C-z>", ":undo<CR>")
map("n", "<C-r>", ":redo<CR>")

map("v", '"', 's""<ESC>P')
map("v", "'", "s''<ESC>P")
map("v", "`", "s``<ESC>P")
map("v", "{", "s{}<ESC>P")
map("v", "(", "s()<ESC>P")
map("v", "[", "s[]<ESC>P")
map("v", "<C-w>", "s<></><ESC>hhi<ENTER><ESC>kpI<TAB><ESC>ki")

map("n", "ss", ":split<CR><C-w>w", { silent = true })
map("n", "sv", ":vsplit<CR><C-w>w", { silent = true })

map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>")
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>")

map("n", "<C-a>", "gg<S-v>G")
