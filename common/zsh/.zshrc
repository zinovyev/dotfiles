# History config
export HISTSIZE=10000       # Max amount of lines to keep in history
export SAVEHIST=10000       # Max amount of lines that can be stored
HISTFILE=~/.zsh_history     # History file
setopt HIST_IGNORE_ALL_DUPS # Don't save duplicates to history
setopt HIST_FIND_NO_DUPS    # Do not display a line previously found.
setopt SHARE_HISTORY        # Share history between all sessions.
setopt INC_APPEND_HISTORY   # Write to the history file immediately
setopt PROMPT_SUBST         # Expansion of Prompt Sequences

# VIM keybindings
# bindkey -v

# Emacs keybindings
bindkey -e

# Use the up and down keys to navigate the history
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

# History search with Ctrl^R and Ctrl^S
bindkey ^R history-incremental-search-backward 
bindkey ^S history-incremental-search-forward

# Word navigation
bindkey "\eb" backward-word
bindkey "\ef" forward-word
bindkey "\e[1;3D" backward-word
bindkey "\e[1;3C" forward-word
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word
bindkey "\e[5D" backward-word
bindkey "\e[5C" forward-word

# Move to directories without cd
setopt autocd

# Initialize completion
autoload -U compinit; compinit

# Initialize VCS integration
autoload -Uz vcs_info

# Set up fzf key bindings and fuzzy completion
if (which fzf >/dev/null); then
  source <(fzf --zsh)
else
  echo "Missing \"fzf\". Need to install it first."
fi

# Prompt
# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
if [[ -e ~/.git-prompt.sh ]]; then
  source ~/.git-prompt.sh
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWCONFLICTSTATE=yes
  GIT_PS1_SHOWUPSTREAM=auto
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWCOLORHINTS=true # For colored hints
else
  echo "Missing \".git-prompt.sh\". Need to download it first."
fi
PROMPT='%(?.%F{green}√.%F{red}✗)%f %B%F{blue}%~%f%b $(__git_ps1 "(%s) ")$ '

# Aliases
if command -v gls >/dev/null 2>&1; then
  alias ls="gls --color=auto"
elif command -v ls >/dev/null 2>&1; then
  alias ls="ls --color=auto"
fi
alias myip="curl http://ipecho.net/plain; echo"
alias g="git"
alias gi="git"
alias got="git"
alias "??"="tldr"
alias irb="irb --noinspect"
alias curlf='curl -w "$(cat ~/.curl-format)"'
alias yaourt="yay"
alias ltree="tree -L 2 --filelimit 10 --dirsfirst"
alias dush='du -sch .[!.]* * | sort -h'
alias vi="nvim"
alias vim="nvim"
# alias docker="podman"

# PATH
export PATH="${PATH}:${HOME}/.scripts"        # Public scripts
export PATH="${PATH}:${HOME}/.pscripts"       # Private scripts that shouldn't be shared with dotfiles

# Enable ASDF support
# export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Enable Mise support
eval "$(mise activate zsh)"

# ASDF hook
eval "$(direnv hook zsh)"

# ENV vars
export EDITOR=vim

# OS-specific shell extensions
case "$(uname -s)" in
  Linux)
    if [ -f "${HOME}/.zshrc.linux" ]; then source "${HOME}/.zshrc.linux"; fi
    ;;
  Darwin)
    if [ -f "${HOME}/.zshrc.macos" ]; then source "${HOME}/.zshrc.macos"; fi
    ;;
esac

# Private credentials etc
if [ -f "${HOME}/.pzshrc" ]; then source "${HOME}/.pzshrc"; fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/Src/google-cloud-sdk/path.zsh.inc" ]; then . "${HOME}/Src/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${HOME}/Src/google-cloud-sdk/completion.zsh.inc" ]; then . "${HOME}/Src/google-cloud-sdk/completion.zsh.inc"; fi
