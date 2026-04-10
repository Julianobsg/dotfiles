local api = vim.api
local python_settings = api.nvim_create_augroup("python-settings", { clear = true })
local gdscript_settings = api.nvim_create_augroup("gdscript-settings", { clear = true })
local appearance = api.nvim_create_augroup("appearance", { clear = true })

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
  group = python_settings,
  pattern = "python",
  callback = function(args)
    vim.bo[args.buf].softtabstop = 4
    vim.bo[args.buf].shiftwidth = 4
    vim.bo[args.buf].tabstop = 4
    vim.opt_local.textwidth = 88
    vim.opt_local.colorcolumn = "89"
  end,
})

api.nvim_create_autocmd("FileType", {
  group = gdscript_settings,
  pattern = "gdscript",
  callback = function(args)
    vim.bo[args.buf].softtabstop = 0
    vim.bo[args.buf].shiftwidth = 4
    vim.bo[args.buf].tabstop = 4

    vim.keymap.set("n", "<F4>", "<cmd>GodotRunLast<cr>", { buffer = true, silent = true })
    vim.keymap.set("n", "<F5>", "<cmd>GodotRun<cr>", { buffer = true, silent = true })
    vim.keymap.set("n", "<F6>", "<cmd>GodotRunCurrent<cr>", { buffer = true, silent = true })
    vim.keymap.set("n", "<F7>", "<cmd>GodotRunFZF<cr>", { buffer = true, silent = true })
  end,
})

api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  group = appearance,
  callback = set_transparent_bg,
})
