#!/bin/sh

# Let's be cool and follow the spec eh?
test "$XDG_CONFIG_HOME" && CONFIGDIR="$XDG_CONFIG_HOME" || CONFIGDIR="$HOME/.config"

test -f "$HOME/.Xresources" && xrdb -merge "$HOME/.Xresources"

# Run xbindkeys if both the program and the config exists
test -f "$CONFIGDIR/xbindkeysrc" \
    && command -v xbindkeys >/dev/null 2>&1 \
    && xbindkeys -f "$CONFIGDIR/xbindkeysrc" &

# Start redshift if it's present
command -v redshift >/dev/null 2>&1 && redshift &

# feh --bg-max # [list of images here]

exec i3
