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

For Neovim formatting/linting/LSP support, install the tools you use, for example:
```
brew install ruff stylua taplo shfmt rubocop
gem install --user-install solargraph
```

The repo also installs a fallback Ruff config at `~/.config/ruff/pyproject.toml`.

Neovim uses Solargraph for Ruby LSP, Ruff and RuboCop for linting, and Conform for formatting in Python, Lua, Rust, Ruby, JavaScript/TypeScript, JSON, CSS, HTML, Markdown, YAML, TOML, shell, and Fish.

Autoformat on save only runs when the project defines formatter config, like Ruff, Prettier, StyLua, rustfmt, RuboCop/Standard, or Taplo config files.

Use `,f` in normal mode to format the file, or in visual mode to format just the selected lines.

After applying the dotfiles, run `:PackerSync` once in Neovim.
