# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load compinit for autocompletion (only in Zsh)
if command -v compinit &> /dev/null; then
  autoload -U compinit && compinit
fi

# Load bash-style completion (if needed and supported)
if command -v bashcompinit &> /dev/null; then
  autoload -U bashcompinit && bashcompinit
fi

# Homebrew Path

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


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
alias ls="eza --icons=always"
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

source /opt/homebrew/share/zsh/site-functions/_skaffold



# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward


export PATH="/opt/homebrew/bin:$PATH"
alias ls='eza -alF --icons'

# Zoxide configuration
eval "$(zoxide init zsh)"

# Alias to make cd behave like z
alias cd="z"

source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

# Enable zsh-autosuggestions if installed
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Enable zsh-syntax-highlighting if installed
if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Ripgrep alias for convenience
alias grep="rg"

# Ripgrep alias for convenience
alias grep="rg"

# Ripgrep alias for convenience
alias grep="rg"

# Ripgrep alias for convenience
alias grep="rg"

# Ripgrep alias for convenience
alias grep="rg"

# Ripgrep alias for convenience
alias grep="rg"

# Ripgrep alias for convenience
alias grep="rg"

# Ripgrep alias for convenience
alias grep="rg"

# Ripgrep alias for convenience
alias grep="rg"

# Ripgrep alias for convenience
alias grep="rg"

# Ripgrep alias for convenience
alias grep="rg"

# Ripgrep alias for convenience
alias grep="rg"

# Ripgrep alias for convenience
alias grep="rg"

# Ripgrep alias for convenience
alias grep="rg"

# Ripgrep alias for convenience
alias grep="rg"

# Ripgrep alias for convenience
alias grep="rg"

# Ripgrep alias for convenience
alias grep="rg"

# Ripgrep alias for convenience
alias grep="rg"

# Ripgrep alias for convenience
alias grep="rg"
