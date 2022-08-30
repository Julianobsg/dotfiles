# dotfiles

Dotfiles, made for Ruby, Rust and Javascript programming.

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
