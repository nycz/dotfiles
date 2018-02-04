#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Prompt:
#   1;32 - bold green
#   \u - username
#   \h - hostname
#   1;34 - bold light blue
#   \W - basename of working dir
#   \$ - # or $
#   0 - reset
# NOTE: you should probably change this to another color
#       to more easier tell the different machines apart
PS1='\e[1;32m\u@\h\e[0m:\e[1;34m\W\e[0m\$ '

# Fancier colors in man
#   mb - start blink
#   md - start bold
#   so - start standout (reverse video)
#   us - start underline
#   me - stop bold, blink, and underline
#   ue - stop underline
#   se - stop standout
man() {
    LESS_TERMCAP_md=$'\e[01;38;5;222m' \
    LESS_TERMCAP_so=$'\e[01;48;5;255;38;5;0m' \
    LESS_TERMCAP_us=$'\e[04;38;5;222m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    command man "$@"
}

# Aliases
test -e ~/.config/aliasrc && . ~/.config/aliasrc

# Bash options
shopt -s direxpand
shopt -s histappend
shopt -s checkwinsize
