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
alias ls="gls --color=auto"
alias myip="curl http://ipecho.net/plain; echo"
alias g="git"
alias vi="nvim"
alias vim="nvim"
# alias docker="podman"

# PATH
export PATH="${PATH}:${HOME}/.scripts"        # Public scripts
export PATH="${PATH}:${HOME}/.pscripts"       # Private scripts that shouldn't be shared with dotfiles
export PATH="${PATH}:$HOME/.config/viver/bin" # Viver vim setup manager

# Enable ASDF support
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# ASDF hook
eval "$(direnv hook zsh)"

# ENV vars
export EDITOR=vim

# Private credentials etc
if [ -f "${HOME}/.pzshrc" ]; then source "${HOME}/.pzshrc"; fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/Src/google-cloud-sdk/path.zsh.inc" ]; then . "${HOME}/Src/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${HOME}/Src/google-cloud-sdk/completion.zsh.inc" ]; then . "${HOME}/Src/google-cloud-sdk/completion.zsh.inc"; fi
