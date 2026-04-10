local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local packer_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.cmd("packadd packer.nvim")
  packer_bootstrap = true
end

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  use({
    "lifepillar/vim-solarized8",
    config = function()
      vim.g.solarized_termtrans = 1
      vim.cmd("colorscheme solarized8")
    end,
  })

  use("tpope/vim-fugitive")
  use("christoomey/vim-tmux-navigator")
  use("tpope/vim-abolish")
  use("rust-lang/rust.vim")
  use("habamax/vim-godot")
  use("vim-scripts/Align")
  use("vim-scripts/SQLUtilities")
  use("tpope/vim-rails")
  use("tpope/vim-bundler")

  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  })

  use({
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })

  use({
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        python = { "ruff" },
      }

      -- Keep Ruff diagnostics up to date while editing Python files.
      local group = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = group,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  })

  if packer_bootstrap then
    require("packer").sync()
  end
end)
