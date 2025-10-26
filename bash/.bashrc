#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vi=nvim
PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"
