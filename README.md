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

After changing Homebrew packages, update the stored Brewfile:

```bash
update-brewfile
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
stow -d common zsh -t ..
stow -d common git -t ..
stow -d common nvim -t ..
stow -d common tmux -t ..
stow -d common scripts -t ..
```

### Linux extras

```bash
stow -d linux zsh -t ..
stow -d linux sway -t ..
stow -d linux waybar -t ..
stow -d linux mako -t ..
stow -d linux udiskie -t ..
stow -d linux alacritty -t ..
stow -d linux doublecmd -t ..
```

### macOS extras

```bash
stow -d macos zsh -t ..
stow -d macos ghostty -t ..
stow -d macos brew -t ..
```

The current `.curl-format` helper file lives in the shared `zsh` package because it is used by the shell alias setup.

## Keybindings

### tmux

The tmux prefix is `Ctrl-a`.

| Key | Action |
| --- | --- |
| `Ctrl-a` `Ctrl-a` | Send prefix through to a nested tmux/app |
| `Ctrl-a` `h` / `j` / `k` / `l` | Move pane left / down / up / right |
| `Ctrl-a` `Alt-h` / `Alt-j` / `Alt-k` / `Alt-l` | Resize pane left / down / up / right by 5 cells |
| `Ctrl-a` `H` / `L` | Previous / next window |
| `Ctrl-a` `Ctrl-o` | Rotate panes in the current window |
| `Ctrl-a` `R` | Reload tmux config |
| `Ctrl-a` `s` | Open `tmux-session-menu` |

Other tmux behavior:

- windows start at index `1`
- mouse support is enabled
- copy mode uses vi keys
- tmux-continuum restore is enabled

### Neovim

The Neovim leader key is `Space`.

| Key | Action |
| --- | --- |
| `Space` `?` | Show buffer-local keymaps with which-key |
| `Space` `e` | Focus or toggle the file drawer |
| `Space` `l` | Toggle search highlight |
| `Space` `bn` / `bp` | Next / previous buffer |
| `Space` `bb` or `Space` `` ` `` | Switch to alternate buffer |
| `Space` `ff` | Find files with FZF |
| `Space` `fg` | Live grep with FZF |
| `Space` `fb` | Show buffers with FZF |
| `Space` `fh` | Search help tags with FZF |
| `Space` `fx` / `fX` | Document / workspace diagnostics with FZF |
| `Space` `fs` / `fS` | Document / workspace symbols with FZF |
| `Space` `fr` | Resume the last FZF picker |
| `gd` / `gD` | Go to LSP definition / declaration |
| `gr` | Find LSP references |
| `K` | Show LSP hover docs |
| `Space` `xx` / `xX` | Trouble diagnostics / buffer diagnostics |
| `Space` `cs` / `cl` | Trouble symbols / LSP view |
| `Space` `xL` / `xQ` | Trouble location list / quickfix list |
| `Ctrl-h` / `Ctrl-j` / `Ctrl-k` / `Ctrl-l` | Navigate left / down / up / right across Neovim and tmux panes |
| `Ctrl-\` | Navigate to the previous Neovim/tmux pane |

Inside the nvim-tree drawer:

| Key | Action |
| --- | --- |
| `?` | Toggle help |
| `Ctrl-t` | Change root to parent directory |
| `t` | Open selected node in a new tab |
| `v` | Open selected node in a vertical split |
| `s` or `i` | Open selected node in a horizontal split |
| `h` | Toggle hidden files |

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
- `brew`: Homebrew bundle dump

## Direction

The first structural split is now in place.

Next work:

- keep shared workflow config in `common`
- move Linux desktop specifics into `linux`
- keep macOS terminal/login specifics in `macos`
- add the future Sway-related Linux layer without polluting the shared baseline
