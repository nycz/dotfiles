#!/bin/sh

test -f ~/.Xresources && xrdb -merge ~/.Xresources

redshift &

feh --bg-max # [list of images here]

exec i3
