# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/) for Ruby, Rust, JavaScript/TypeScript, Python, shell, and terminal workflows.

## Start Here

Use [docs/tools.md](docs/tools.md) as the detailed tooling reference. It is written for both GitHub navigation and AI agents that need to understand which tools are configured, where each behavior lives, and which commands or keymaps are available.

## Installation

Use the installation path for your machine:

- [macOS](docs/install.md#macos)
- [Arch Linux](docs/install.md#arch-linux)

The full installation reference is in [docs/install.md](docs/install.md).

After installing the required packages, apply the dotfiles:

```bash
chezmoi init --apply https://github.com/Julianobsg/dotfiles.git
```

## After Applying

Open Neovim and run `:PackerSync` once so Packer can install the configured plugins.

Use `,f` in normal mode to format the current file, or in visual mode to format only the selected lines.

Autoformat on save only runs when a project defines formatter configuration, such as Ruff, Prettier, StyLua, rustfmt, RuboCop, Standard, or Taplo config files. Shell and Fish formatters are configured for manual formatting through `,f`.

The repo also installs a fallback Ruff config at `~/.config/ruff/pyproject.toml`.

## Repository Map

| Path | Purpose |
| --- | --- |
| [docs/install.md](docs/install.md) | macOS and Arch Linux installation options. |
| [docs/tools.md](docs/tools.md) | Tooling reference for installed tools, Neovim behavior, commands, and keymaps. |
| [dot_config/nvim/init.lua](dot_config/nvim/init.lua) | Neovim entry point. Loads options, keymaps, autocommands, plugins, and Ruby LSP. |
| [dot_config/nvim/lua/config/packer.lua](dot_config/nvim/lua/config/packer.lua) | Packer plugin list plus linting, formatting, and Diffview PR command setup. |
| [dot_config/nvim/lua/config/keymaps.lua](dot_config/nvim/lua/config/keymaps.lua) | Neovim navigation and ripgrep keymaps. |
| [dot_config/nvim/lua/config/options.lua](dot_config/nvim/lua/config/options.lua) | Editor options and tmux navigator mappings. |
| [dot_config/nvim/lua/config/autocmds.lua](dot_config/nvim/lua/config/autocmds.lua) | Filetype-specific editor behavior and appearance tweaks. |
| [dot_config/nvim/lsp/solargraph.lua](dot_config/nvim/lsp/solargraph.lua) | Ruby Solargraph LSP configuration. |
| [dot_config/ruff/pyproject.toml](dot_config/ruff/pyproject.toml) | Fallback Ruff configuration installed to `~/.config/ruff/pyproject.toml`. |
| [dot_tmux.conf](dot_tmux.conf) | tmux prefix, splits, pane navigation, resize keys, colors, and local override hook. |
| [dot_config/private_fish/config.fish](dot_config/private_fish/config.fish) | Fish shell editor environment. |
| [dot_config/private_fish/conf.d/tmux.fish](dot_config/private_fish/conf.d/tmux.fish) | Fish startup hook that attaches to a base tmux session. |
| [dot_config/alacritty/alacritty.toml](dot_config/alacritty/alacritty.toml) | Alacritty terminal theme, font, window, keyboard, and mouse settings. |
