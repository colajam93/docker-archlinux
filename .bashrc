#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
PS1='[\u@\h \W]\$ '
export EDITOR=vim
complete -cf sudo
complete -cf man
