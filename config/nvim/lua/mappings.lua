require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
local map = vim.keymap.set

for i = 1, 9 do
  map("n", "<leader>" .. i, function()
    local bufs = vim.t.bufs or {}
    if bufs[i] then
      vim.api.nvim_set_current_buf(bufs[i])
    end
  end, { desc = "Switch to buffer " .. i })
end
