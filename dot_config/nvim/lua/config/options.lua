vim.opt.number = true
vim.opt.cmdheight = 1

vim.opt.background = "dark"
vim.opt.termguicolors = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.grepprg = "rg --vimgrep --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true

vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 3
vim.opt.foldenable = false

vim.g.tmux_navigator_no_mappings = 1
local map = vim.keymap.set
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true, desc = "Tmux left" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true, desc = "Tmux down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true, desc = "Tmux up" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true, desc = "Tmux right" })
map("n", "<C-/>", "<cmd>TmuxNavigatePrevious<cr>", { silent = true, desc = "Tmux previous" })
