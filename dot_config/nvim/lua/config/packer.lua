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
  use("elixir-editors/vim-elixir")
  use("habamax/vim-godot")
  use("othree/html5.vim")
  use("pangloss/vim-javascript")
  use("evanleck/vim-svelte")
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
        ruby = { "rubocop" },
      })

      local lint_filetypes = {
        python = true,
        ruby = true,
      }

      -- Keep diagnostics up to date while editing files handled by nvim-lint.
      local group = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = group,
        callback = function(args)
          if lint_filetypes[vim.bo[args.buf].filetype] then
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
      local prettier_filetypes = {
        javascript = true,
        javascriptreact = true,
        typescript = true,
        typescriptreact = true,
        json = true,
        jsonc = true,
        css = true,
        scss = true,
        html = true,
        yaml = true,
        markdown = true,
      }
      local project_config_files = {
        lua = { "stylua.toml", ".stylua.toml" },
        rust = { "rustfmt.toml", ".rustfmt.toml" },
        ruby = {
          ".rubocop.yml",
          ".rubocop.yaml",
          "rubocop.yml",
          "rubocop.yaml",
          ".standard.yml",
        },
        toml = { "taplo.toml", ".taplo.toml" },
      }

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

      local function file_contains(path, pattern)
        local ok, lines = pcall(vim.fn.readfile, path)
        if not ok then
          return false
        end

        return table.concat(lines, "\n"):match(pattern) ~= nil
      end

      local function read_json(path)
        local ok, lines = pcall(vim.fn.readfile, path)
        if not ok then
          return nil
        end

        local success, decoded = pcall(vim.json.decode, table.concat(lines, "\n"))
        if not success then
          return nil
        end

        return decoded
      end

      local function python_has_project_ruff_config(bufnr)
        if find_project_file(bufnr, { "ruff.toml", ".ruff.toml" }) then
          return true
        end

        local pyproject = find_project_file(bufnr, { "pyproject.toml" })
        if not pyproject then
          return false
        end

        return file_contains(pyproject, "%[tool%.ruff")
      end

      local function prettier_has_project_config(bufnr)
        if find_project_file(bufnr, {
          ".prettierrc",
          ".prettierrc.json",
          ".prettierrc.yml",
          ".prettierrc.yaml",
          ".prettierrc.json5",
          ".prettierrc.toml",
          ".prettierrc.js",
          ".prettierrc.cjs",
          ".prettierrc.mjs",
          "prettier.config.js",
          "prettier.config.cjs",
          "prettier.config.mjs",
          "prettier.config.ts",
        }) then
          return true
        end

        local package_json = find_project_file(bufnr, { "package.json" })
        if not package_json then
          return false
        end

        local decoded = read_json(package_json)
        return decoded ~= nil and decoded.prettier ~= nil
      end

      local function has_project_formatter_config(bufnr)
        local filetype = vim.bo[bufnr].filetype
        if filetype == "python" then
          return python_has_project_ruff_config(bufnr)
        end

        if prettier_filetypes[filetype] then
          return prettier_has_project_config(bufnr)
        end

        local names = project_config_files[filetype]
        if not names then
          return false
        end

        return find_project_file(bufnr, names) ~= nil
      end

      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          rust = { "rustfmt" },
          ruby = { "rubocop", "standardrb", stop_after_first = true },
          javascript = { "prettierd", "prettier", stop_after_first = true },
          javascriptreact = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          typescriptreact = { "prettierd", "prettier", stop_after_first = true },
          json = { "prettierd", "prettier", stop_after_first = true },
          jsonc = { "prettierd", "prettier", stop_after_first = true },
          css = { "prettierd", "prettier", stop_after_first = true },
          scss = { "prettierd", "prettier", stop_after_first = true },
          html = { "prettierd", "prettier", stop_after_first = true },
          markdown = { "prettierd", "prettier", stop_after_first = true },
          yaml = { "prettierd", "prettier", stop_after_first = true },
          toml = { "taplo" },
          sh = { "shfmt" },
          bash = { "shfmt" },
          zsh = { "shfmt" },
          fish = { "fish_indent" },
          python = { "ruff_organize_imports", "ruff_format" },
        },
        format_on_save = function(bufnr)
          -- Only autoformat when the project defines formatter settings itself.
          if not has_project_formatter_config(bufnr) then
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
