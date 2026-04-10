# dotfiles

Dotfiles, made for Ruby, Rust, Javascript and Python programming.

## Instalation

Installing depencies:

Install allacrity: https://github.com/alacritty/alacritty/releases

Installing brew, chezmoi and oh-my-zsh
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install chezmoi

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Initialize chezmoi
```
chezmoi init --apply https://github.com/Julianobsg/dotfiles.git
```
I'm using [chezmoi](https://www.chezmoi.io/docs/install/) to config the dotfiles.

For Python support in Neovim, install `ruff` too:
```
brew install ruff
```

The repo also installs a fallback Ruff config at `~/.config/ruff/pyproject.toml`.

Python buffers in Neovim use Ruff for linting, and they only autoformat on save when the project defines Ruff config in `pyproject.toml`, `ruff.toml`, or `.ruff.toml`.

Use `,f` in normal mode to format the file, or in visual mode to format just the selected lines.

After applying the dotfiles, run `:PackerSync` once in Neovim.
