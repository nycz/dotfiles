#!/bin/sh

test -f ~/.Xresources && xrdb -merge ~/.Xresources

test -f ~/.config/xbindkeysrc && command -v xbindkeys >/dev/null 2>&1 && xbindkeys -f ~/.config/xbindkeysrc &

# Start redshift if it's present
command -v redshift >/dev/null 2>&1 && redshift &

feh --bg-max # [list of images here]

exec i3
