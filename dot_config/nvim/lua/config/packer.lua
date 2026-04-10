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

      lint.linters_by_ft = vim.tbl_extend("force", lint.linters_by_ft or {}, {
        python = { "ruff" },
      })

      -- Keep Ruff diagnostics up to date while editing Python files.
      local group = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = group,
        callback = function(args)
          if vim.bo[args.buf].filetype == "python" then
            lint.try_lint()
          end
        end,
      })
    end,
  })

  use({
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")

      local function find_project_file(bufnr, names)
        local path = vim.api.nvim_buf_get_name(bufnr)
        if path == "" then
          return nil
        end

        return vim.fs.find(names, {
          path = vim.fs.dirname(path),
          upward = true,
          type = "file",
        })[1]
      end

      local function python_has_project_ruff_config(bufnr)
        if find_project_file(bufnr, { "ruff.toml", ".ruff.toml" }) then
          return true
        end

        local pyproject = find_project_file(bufnr, { "pyproject.toml" })
        if not pyproject then
          return false
        end

        return table.concat(vim.fn.readfile(pyproject), "\n"):match("%[tool%.ruff") ~= nil
      end

      conform.setup({
        formatters_by_ft = {
          python = { "ruff_organize_imports", "ruff_format" },
        },
        format_on_save = function(bufnr)
          if vim.bo[bufnr].filetype ~= "python" then
            return
          end

          -- Only autoformat when the project defines Ruff settings itself.
          if not python_has_project_ruff_config(bufnr) then
            return
          end

          return { timeout_ms = 500 }
        end,
      })

      vim.keymap.set({ "n", "v" }, ",f", function()
        conform.format({ async = true })
      end, { silent = true, desc = "Format buffer or selection" })
    end,
  })

  if packer_bootstrap then
    require("packer").sync()
  end
end)
