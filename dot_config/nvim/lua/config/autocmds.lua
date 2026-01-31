local api = vim.api

local function set_transparent_bg()
  local groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "FloatBorder",
    "SignColumn",
    "LineNr",
    "FoldColumn",
    "EndOfBuffer",
  }

  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE" })
  end
end

api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.bo.softtabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end,
})

api.nvim_create_autocmd("FileType", {
  pattern = "gdscript",
  callback = function()
    vim.bo.softtabstop = 0
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4

    vim.keymap.set("n", "<F4>", "<cmd>GodotRunLast<cr>", { buffer = true, silent = true })
    vim.keymap.set("n", "<F5>", "<cmd>GodotRun<cr>", { buffer = true, silent = true })
    vim.keymap.set("n", "<F6>", "<cmd>GodotRunCurrent<cr>", { buffer = true, silent = true })
    vim.keymap.set("n", "<F7>", "<cmd>GodotRunFZF<cr>", { buffer = true, silent = true })
  end,
})

api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  callback = set_transparent_bg,
})
