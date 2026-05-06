# Installation

This repo supports two practical setup paths: macOS with Homebrew and Arch Linux with pacman. Install only the tools needed for the languages and workflows you use.

## macOS

Install Homebrew if it is not already installed:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install the base tools used by this configuration:

```bash
brew install chezmoi git neovim tmux fish ripgrep ruff stylua taplo shfmt node ruby
brew install --cask alacritty
```

Install Oh My Zsh if you use zsh on the machine:

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Arch Linux

Install the base tools used by this configuration:

```bash
sudo pacman -Syu
sudo pacman -S --needed chezmoi git neovim tmux fish ripgrep ruff stylua taplo-cli shfmt nodejs npm ruby rustup alacritty zsh
```

Install Oh My Zsh if you use zsh on the machine:

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

On Arch Linux, the `taplo-cli` package provides the `taplo` executable used by Neovim.

## Shared Language Tools

These commands install executables expected by the Neovim LSP, linting, and formatting configuration. Use your existing Ruby, Node, or Rust version manager instead if you prefer.

If `rustup` is not already available, install it with the official installer:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
```

Install the language-specific tools:

```bash
gem install --user-install solargraph rubocop standard
npm install -g @fsouza/prettierd prettier
rustup default stable
rustup component add rustfmt
```

If `gem --user-install` puts executables outside `PATH`, add the RubyGems user bin directory to your shell path. For Fish:

```fish
fish_add_path (ruby -e 'print Gem.user_dir')/bin
```

## Apply Dotfiles

Apply this repository with chezmoi:

```bash
chezmoi init --apply https://github.com/Julianobsg/dotfiles.git
```

After applying, open Neovim and run `:PackerSync` once.
