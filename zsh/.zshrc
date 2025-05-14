#!/usr/bin/env zsh

# Load compinit for autocompletion (only in Zsh)
if command -v compinit &> /dev/null; then
  autoload -U compinit && compinit
fi

# Load bash-style completion (if needed and supported)
if command -v bashcompinit &> /dev/null; then
  autoload -U bashcompinit && bashcompinit
fi

# Homebrew Path
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Aliases for Kubernetes
alias k="kubectl"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias kdp="kubectl describe pod"
alias kds="kubectl describe service"
alias klog="kubectl logs"
alias kaf="kubectl apply -f"
alias krm="kubectl delete -f"
alias kex="kubectl exec -it"

# Aliases for Git
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

# Aliases for Docker
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

# General Dev Aliases
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias c="clear"
alias h="history"
alias v="vim"
alias e="echo"

# NVM Configuration (commented out)
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Load nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Load nvm bash_completion

# Terraform autocomplete
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# Custom prompt
export PS1="%n@%m %1~ %# "

# User configuration
export LANG=en_US.UTF-8

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
