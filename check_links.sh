#!/bin/sh

# Check all files in the repo and see which ones are symlinked
# to their respective places and which ones are not

test "$XDG_CONFIG_HOME" && CONFIGDIR="$XDG_CONFIG_HOME" || CONFIGDIR="$HOME/.config"

print_result() {
    STATUS="$1"
    COLOR="$2"
    FNAME="$3"
    printf '%s|\033[%sm%s\033[0m\n' "$FNAME" "$COLOR" "$STATUS"
}

same_file() {
    # Do they exist
    if test -f "$2" ; then
        # See if they are symlinked
        if test "$(stat -Lc '%d:%i' "$1")" = "$(stat -Lc '%d:%i' "$2")" ; then
            print_result 'symlinked' '1;32' "$2"
        else
            # Well are they at least identical
            if cmp -s "$1" "$2" 2>/dev/null ; then
                print_result 'identical content' '1;35' "$2"
            else
                print_result 'mismatched content' '1;31' "$2"
            fi
        fi
    else
        print_result 'missing' '36' "$2"
    fi
}

same_directory() {
    for f in $(cd "$1" && find * -type 'f') ; do same_file "$1/$f" "$2/$f" ; done
}

{
    # $HOME/
    same_file  'bash_profile'   "$HOME/.bash_profile"
    same_file  'bashrc'         "$HOME/.bashrc"
    same_file  'gitconfig'      "$HOME/.gitconfig"
    same_file  'inputrc'        "$HOME/.inputrc"
    same_file  'profile'        "$HOME/.profile"
    same_file  'tmux.conf'      "$HOME/.tmux.conf"
    same_file  'xinitrc'        "$HOME/.xinitrc"
    same_file  'Xresources'     "$HOME/.Xresources"

    # ~/.config/
    same_file  'compton.conf'   "$CONFIGDIR/compton.conf"
    same_file  'aliasrc'        "$CONFIGDIR/aliasrc"
    same_file  'user-dirs.dirs' "$CONFIGDIR/user-dirs.dirs"
    #same_file 'mpd.conf'       "$CONFIGDIR/mpd.conf"

    # directories
    same_directory  'vifm'         "$CONFIGDIR/vifm"
    same_directory  'i3'           "$CONFIGDIR/i3"
    same_directory  'i3status'     "$CONFIGDIR/i3status"
    same_directory  'lxterminal'   "$CONFIGDIR/lxterminal"
    same_directory  'nvim'         "$CONFIGDIR/nvim"
    same_directory  'xorg.conf.d'  '/etc/X11/xorg.conf.d'
} | column -t -s'|' | sed "s/\\\\x1b/\\x1b/g"
