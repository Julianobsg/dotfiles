local map = vim.keymap.set

map("n", "<C-\\>", "<cmd>Neotree toggle<cr>", { silent = true, desc = "Explorer" })
map("n", ",t", "<cmd>Telescope find_files<cr>", { silent = true, desc = "Find files" })
