local map = vim.keymap.set

map("n", "<C-\\>", "<cmd>Neotree reveal<cr>", { silent = true, desc = "Explorer" })
map("n", ",t", "<cmd>Telescope find_files<cr>", { silent = true, desc = "Find files" })
map("n", ",g", "<cmd>Telescope live_grep<cr>", { silent = true, desc = "Live grep" })

vim.api.nvim_create_user_command("Rg", "silent grep! <args> | copen", {
  nargs = "+",
  complete = "file_in_path",
  desc = "Search with ripgrep into quickfix",
})

vim.cmd([[cnoreabbrev <expr> rg getcmdtype() == ':' && getcmdline() ==# 'rg' ? 'Rg' : 'rg']])
