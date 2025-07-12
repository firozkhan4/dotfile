#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /usr/share/git/completion/git-prompt.sh
source /usr/share/nvm/init-nvm.sh

source /home/firoz/dotfile/bash/.config/bash/bash_alias.sh

PS1='\[\e[32m\]\u@\h\[\e[0m\]::\[\e[33m\]\W\[\e[36m\]$(__git_ps1 " (%s)")\[\e[0m\] 🐱\n\$ '

