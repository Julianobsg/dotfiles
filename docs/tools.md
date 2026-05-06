# Tools

This document expands the tooling notes from the [README](../README.md). It is intended for human browsing in GitHub and for AI agents that need a concise map from behavior to source configuration.

## Tool Matrix

| Area | Tools | Source |
| --- | --- | --- |
| Dotfile manager | chezmoi | [README](../README.md), [docs/install.md](install.md), [.chezmoiignore](../.chezmoiignore) |
| Terminal | Alacritty | [dot_config/alacritty/alacritty.toml](../dot_config/alacritty/alacritty.toml) |
| Shell and sessions | Fish, tmux | [dot_config/private_fish/config.fish](../dot_config/private_fish/config.fish), [dot_config/private_fish/conf.d/tmux.fish](../dot_config/private_fish/conf.d/tmux.fish), [dot_tmux.conf](../dot_tmux.conf) |
| Editor | Neovim, Packer | [dot_config/nvim/init.lua](../dot_config/nvim/init.lua), [dot_config/nvim/lua/config/packer.lua](../dot_config/nvim/lua/config/packer.lua) |
| Search and navigation | ripgrep, Telescope, Neo-tree, vim-tmux-navigator | [dot_config/nvim/lua/config/options.lua](../dot_config/nvim/lua/config/options.lua), [dot_config/nvim/lua/config/keymaps.lua](../dot_config/nvim/lua/config/keymaps.lua), [dot_config/nvim/lua/config/packer.lua](../dot_config/nvim/lua/config/packer.lua) |
| Git review | vim-fugitive, Diffview | [dot_config/nvim/lua/config/packer.lua](../dot_config/nvim/lua/config/packer.lua) |
| LSP, linting, formatting | Solargraph, Ruff, RuboCop, Standard, Conform, nvim-lint, Prettier, Prettierd, StyLua, rustfmt, Taplo, shfmt, fish_indent | [dot_config/nvim/lsp/solargraph.lua](../dot_config/nvim/lsp/solargraph.lua), [dot_config/nvim/lua/config/packer.lua](../dot_config/nvim/lua/config/packer.lua), [dot_config/ruff/pyproject.toml](../dot_config/ruff/pyproject.toml) |

## Installation Reference

Use [docs/install.md](install.md) for macOS and Arch Linux package commands. Package names differ by OS, especially `taplo` on macOS versus `taplo-cli` on Arch Linux.

Install only the tools needed for the languages and workflows you use. The Neovim config tolerates missing formatters until you invoke formatting or linting for that language.

## Neovim Overview

Neovim starts at [dot_config/nvim/init.lua](../dot_config/nvim/init.lua). It sets `,` as the leader key, loads the config modules, and enables the Ruby `solargraph` LSP configuration.

Packer is bootstrapped from [dot_config/nvim/lua/config/packer.lua](../dot_config/nvim/lua/config/packer.lua). After applying these dotfiles on a new machine, run `:PackerSync` once inside Neovim.

Notable plugins include `packer.nvim`, `vim-solarized8`, `vim-fugitive`, `vim-tmux-navigator`, `neo-tree.nvim`, `telescope.nvim`, `diffview.nvim`, `nvim-lint`, `conform.nvim`, language plugins for Rust, Elixir, Godot, HTML, JavaScript, Svelte, Rails, and Bundler, plus `Align` and `SQLUtilities`.

## Neovim Commands And Keymaps

| Command or key | Behavior | Source |
| --- | --- | --- |
| `,f` | Format the current buffer or visual selection through Conform. | [packer.lua](../dot_config/nvim/lua/config/packer.lua) |
| `,t` | Open Telescope file search. | [keymaps.lua](../dot_config/nvim/lua/config/keymaps.lua) |
| `,g` | Open Telescope live grep. | [keymaps.lua](../dot_config/nvim/lua/config/keymaps.lua) |
| `<C-\>` | Reveal the current file in Neo-tree. | [keymaps.lua](../dot_config/nvim/lua/config/keymaps.lua) |
| `:Rg {pattern}` | Search with ripgrep and open results in quickfix. The lowercase `:rg` command is abbreviated to `:Rg`. | [keymaps.lua](../dot_config/nvim/lua/config/keymaps.lua), [options.lua](../dot_config/nvim/lua/config/options.lua) |
| `:PR [base-or-range]` | Open a PR-style Diffview comparison. With no argument, it tries `origin/HEAD`, `origin/main`, `origin/master`, `main`, then `master`. | [packer.lua](../dot_config/nvim/lua/config/packer.lua) |
| `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` | Move across Neovim and tmux panes. | [options.lua](../dot_config/nvim/lua/config/options.lua), [dot_tmux.conf](../dot_tmux.conf) |
| `<F4>` through `<F7>` in GDScript | Run Godot commands for last/current/project selections. | [autocmds.lua](../dot_config/nvim/lua/config/autocmds.lua) |

## Formatting And Linting

Manual formatting with `,f` is available for configured formatters. Autoformat on save is intentionally conservative and only runs when the current project owns formatter configuration.

| Filetype | Formatter or linter | Autoformat condition |
| --- | --- | --- |
| Python | Ruff linting, `ruff_organize_imports`, `ruff_format` | `ruff.toml`, `.ruff.toml`, or `pyproject.toml` containing `[tool.ruff]` |
| Ruby | RuboCop linting, `rubocop`, `standardrb` | `.rubocop.yml`, `.rubocop.yaml`, `rubocop.yml`, `rubocop.yaml`, or `.standard.yml` |
| JavaScript, TypeScript, JSON, CSS, SCSS, HTML, YAML, Markdown | `prettierd`, `prettier` | Prettier config file or `package.json` containing a `prettier` key |
| Lua | `stylua` | `stylua.toml` or `.stylua.toml` |
| Rust | `rustfmt` | `rustfmt.toml` or `.rustfmt.toml` |
| TOML | `taplo` | `taplo.toml` or `.taplo.toml` |
| shell, Bash, Zsh | `shfmt` | Manual formatting through `,f` |
| Fish | `fish_indent` | Manual formatting through `,f` |

`nvim-lint` runs Ruff for Python and RuboCop for Ruby on `BufEnter`, `BufWritePost`, and `InsertLeave`.

The fallback Ruff config at [dot_config/ruff/pyproject.toml](../dot_config/ruff/pyproject.toml) is installed to `~/.config/ruff/pyproject.toml`. It sets line length to 88 and enables `B`, `I`, and `UP` lint rule families.

## tmux And Fish

tmux uses `C-a` as the prefix, starts window and pane indexes at `1`, enables mouse support, and keeps a Solarized-style status line in [dot_tmux.conf](../dot_tmux.conf).

tmux split keys preserve the current pane directory: `prefix v` and `prefix C-v` split horizontally, while `prefix s` and `prefix C-s` split vertically.

Pane resizing uses repeatable `prefix H`, `prefix J`, `prefix K`, and `prefix L`. Reload the tmux config with `prefix r`.

Fish sets `EDITOR` to `nvim` in [config.fish](../dot_config/private_fish/config.fish). The tmux startup hook in [tmux.fish](../dot_config/private_fish/conf.d/tmux.fish) attaches to a detached `base` tmux session when Fish starts outside tmux.

## Alacritty

Alacritty uses a Solarized dark palette, `Fira Mono` at size `14`, `xterm-256color`, block cursor, slight window opacity, and macOS-style `Command-C` and `Command-V` copy/paste bindings. See [alacritty.toml](../dot_config/alacritty/alacritty.toml).

## Maintenance Notes

When changing tool behavior, update the source config and this document in the same change. The README should stay short and link here for implementation detail.

Keep generated or repository-only documentation in `.chezmoiignore` so chezmoi does not apply it into the home directory.
