#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PATH=$PATH:$HOME/bin

alias ls='ls --color=always'
PS1='[\u@\h \W]\$ '

export EDITOR="vim"

source /usr/share/git/completion/git-completion.bash

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
