#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /usr/share/git/completion/git-prompt.sh
source /usr/share/nvm/init-nvm.sh

source /home/firoz/dotfile/bash/.config/bash/bash_alias.sh
source /home/firoz/dotfile/bash/.config/bash/bash_exports.sh


PS1='\[\e[32m\]\u@\h\[\e[0m\]::\[\e[33m\]\W\[\e[36m\]$(__git_ps1 " (%s)")\[$( [[ -n "$ENV_TYPE" ]] && echo "\e[35m" )\]$( [[ -n "$ENV_TYPE" ]] && echo " [$ENV_TYPE]" )\[\e[0m\] 🐱\n\$ '

cd() {
  builtin cd "$@" || return

  if [[ -f .env ]]; then
    if grep -q '^NODE_ENV=' .env; then
      export ENV_TYPE=$(grep '^NODE_ENV=' .env | cut -d '=' -f2-)
    fi
  fi
}

setenv() {
  if [[ $# -ne 1 ]]; then
    echo "Usage: setenv <env-type>"
    return 1
  fi

  local TYPE=$1

  if [[ -f .env ]]; then
    if grep -q '^NODE_ENV=' .env; then
      sed -i.bak "s/^NODE_ENV=.*/NODE_ENV=$TYPE/" .env && rm -f .env.bak
    else
      echo "NODE_ENV=$TYPE" >> .env
    fi
    export ENV_TYPE=$TYPE
  else
    notify-send -u critical -i dialog-warning "Environment Error" "⚠️ No .env file found in the current directory"
    return 1
  fi
}

. "$HOME/.cargo/env"
