#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -l'
alias nfzf='nvim "$(fzf)"'
alias bgchange="~/.bash/bgchange.sh"
alias pwdc="pwd | xclip -i"
alias pwdp='cd "$(xclip -o)"'
alias lg='lazygit'


hfzf() {
  local selected

  selected=$(history | fzf)

  # Exit if nothing selected
  [ -z "$selected" ] && return

  # Strip the leading history number
  IFS=' ' read -ra command <<< "$selected"

  # Insert into current readline buffer
  READLINE_LINE="${command[1]}"
  READLINE_POINT=${#READLINE_LINE}
}

# Bind to Ctrl+R
bind -x '"\C-r": hfzf'

todo() {
  make -s -C /home/firoz/Coding/Todo ARGS="$*"
}

source /usr/share/git/completion/git-prompt.sh

PS1='\[\e[32m\]\u@\h\[\e[0m\]::\[\e[33m\]\W\[\e[36m\]$(__git_ps1 " (%s)")\[\e[0m\] 🐱\n\$ '



#eval "$(dircolors -b)"
#export LS_COLORS="$(LS_COLORS:di=1;34:ln=1;36:so=1;35:pi=1;33:ex=1;32)"

# export GTK_IM_MODULE=ibus
# export XMODIFIERS=@im=ibus
# export QT_IM_MODULE=ibus
export PATH="$PATH:$(go env GOPATH)/bin"
# ibus-daemon -drx &

# Load Angular CLI autocompletion.
# source <(ng completion script)
. "$HOME/.cargo/env"
export PATH=$PATH:/snap/bin
