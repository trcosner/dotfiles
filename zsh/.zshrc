# -------------------------
# Powerlevel10k Instant Prompt (must stay at the top)
# -------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -------------------------
# Environment Setup
# -------------------------
export LANG=en_US.UTF-8
export EDITOR="nvim"
export PS1="%n@%m %1~ %# "

# PATH modifications
export PATH="/opt/homebrew/opt/p7zip/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# -------------------------
# Zsh Completion & Plugins
# -------------------------
if command -v compinit &> /dev/null; then
  autoload -U compinit && compinit
fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# Enable zsh-autosuggestions if installed
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Enable zsh-syntax-highlighting if installed
if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Zoxide configuration
eval "$(zoxide init zsh)"
alias cd="z"

# Starship prompt
eval "$(starship init zsh)"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Powerlevel10k prompt config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

# -------------------------
# Aliases
# -------------------------
alias vim="nvim"
alias v="vim"
alias e="echo"
alias c="clear"
alias h="history"

# ls / eza
alias ls='eza -alF --icons'
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

# grep (ripgrep)
alias grep="rg"

# Git
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline"
alias gco="git checkout"
alias gb="git branch"
alias gd="git diff"
alias gm="git merge"
alias grb="git rebase"
alias gcl="git clone"
alias grh="git reset --hard"
alias gst="git stash"
alias gsp="git stash pop"
alias gpr="git pull --rebase"

# Docker
alias dps="docker ps"
alias dpl="docker pull"
alias dbu="docker build -t"
alias dimg="docker images"
alias drm="docker rm"
alias drmi="docker rmi"
alias dexec="docker exec -it"
alias dlog="docker logs"
alias dstop="docker stop"
alias drun="docker run -d"
alias dstart="docker start"
alias dkill="docker kill"
alias dvol="docker volume ls"
alias dnet="docker network ls"

# Kubernetes
alias k="kubectl"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias kdp="kubectl describe pod"
alias kds="kubectl describe service"
alias klog="kubectl logs"
alias kaf="kubectl apply -f"
alias krm="kubectl delete -f"
alias kex="kubectl exec -it"

# -------------------------
# History Settings
# -------------------------
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# -------------------------
# Tool-specific setup
# -------------------------
source /opt/homebrew/share/zsh/site-functions/_skaffold

# Yazi wrapper
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# vscode code command
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"


# Created by `pipx` on 2025-05-29 20:34:20
export PATH="$PATH:/Users/tyler/.local/bin"
