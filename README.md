# Dotfiles

This repo contains the current cross-platform dotfiles baseline:

- shell
- git
- Neovim
- tmux
- small helper scripts
- terminal config where relevant

The current shape is still evolving. The intended direction is a shared baseline with Linux/macOS-specific layers added where needed.

## Current packages

### macOS

Install the current baseline with Homebrew:

```bash
brew install --cask ghostty
brew install zsh
brew install tmux
brew install --cask font-jetbrains-mono-nerd-font
brew install stow
brew install fzf
brew install luarocks
brew install tree
brew install asdf
brew install coreutils
brew install bat
brew install fd
```

Optional tools you may or may not still want:

```bash
brew install television
brew install --cask zed
```

### Arch / Linux

Install the current baseline packages:

```bash
sudo pacman -S stow zsh tmux fzf tree asdf bat fd neovim git curl
```

Additional Linux packages used by the current shell/tooling setup:

```bash
sudo pacman -S qt6ct
```

Notes:

- `ghostty` is currently macOS-oriented in this repo.
- Linux terminal choice is still expected to evolve alongside the planned Sway setup.

## Required extra files

Some local files and directories are intentionally not stored in the repo.

Create them if needed:

```bash
mkdir -p ~/.pscripts
touch ~/.pzshrc
```

These are for:

- private scripts
- local environment overrides
- secrets or machine-specific shell additions

## Git Prompt For zsh

The current prompt expects the Git prompt helper:

```bash
curl -L -o ~/.git-prompt.sh \
  https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
```

## Install With Stow

This repo is now split into layered stow directories:

- `common`
- `linux`
- `macos`

### Common baseline

```bash
stow -d common zsh
stow -d common git
stow -d common nvim
stow -d common tmux
stow -d common scripts
```

### Linux extras

```bash
stow -d linux zsh
stow -d linux sway
stow -d linux waybar
stow -d linux mako
stow -d linux udiskie
stow -d linux alacritty
stow -d linux doublecmd
```

### macOS extras

```bash
stow -d macos zsh
stow -d macos ghostty
```

The current `.curl-format` helper file lives in the shared `zsh` package because it is used by the shell alias setup.

## Current repo contents

### `common`

- `zsh`: shared shell config and support files
- `git`: Git config
- `nvim`: Neovim config
- `tmux`: tmux config
- `scripts`: helper scripts exposed through `~/.scripts`

### `linux`

- `zsh`: Linux-specific shell environment additions
- `sway`: window manager config
- `waybar`: status bar config
- `mako`: notification config
- `udiskie`: mount tray behavior
- `alacritty`: Linux terminal config
- `doublecmd`: file manager config

### `macos`

- `zsh`: macOS login-shell setup
- `ghostty`: terminal config currently used on macOS

## Direction

The first structural split is now in place.

Next work:

- keep shared workflow config in `common`
- move Linux desktop specifics into `linux`
- keep macOS terminal/login specifics in `macos`
- add the future Sway-related Linux layer without polluting the shared baseline
