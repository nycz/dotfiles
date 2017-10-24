#!/bin/sh

# This script will give the option to symlink one or more
# config files to their respective places.

# Note: keep this as portable as humanly possible!
# That includes making it readable (both source and output)
# even on horribly small screens, for example.

SIMULATE='no'

if test "$XDG_CONFIG_HOME" ; then
    CONFIGDIR="$XDG_CONFIG_HOME"
else
    CONFIGDIR="$HOME/.config"
fi

DOTPATH="$(dirname "$(readlink -f "$0")")"

# Prompt the user with a question, return true if answer is "y"
confirm() {
    test "$SKIP_PROMPT" = 'yes' && return
    printf '%s (y/N) ' "$1"
    read yn
    printf '%s' "$yn" | grep -q '^[Yy]$'
}


install_file() {
    SOURCENAME="$1"
    SOURCEPATH="$2"
    TARGETPATH="$3"
    if confirm "Symlink $SOURCENAME -> '$TARGETPATH'?" ; then
        if test "$SIMULATE" = 'yes' ; then
            printf "!! simulation on, no linking\n"
        else
            # Create potentially missing directories
            mkdir -p "$(dirname "$TARGETPATH")"
            ln -s "$SOURCEPATH" "$TARGETPATH"
        fi
        printf "...done\n"
    fi
}

# Symlink a file from the repo to a specified place
install_file_simple() {
    SOURCENAME="$1"
    TARGETPATH="$2"
    install_file "$SOURCENAME" "$DOTPATH/$SOURCENAME" "$TARGETPATH"
}

# For .profile, .bashrc, etc: install into ~
install_to_home() {
    install_file_simple "$1" "$HOME/.$1"
}

# For everything going into ~/.config
install_to_config() {
    install_file_simple "$1" "$CONFIGDIR/$1"
}


# Parse args
while :; do
    case "$1" in
        -s|--simulate)
            printf "Running in simulation mode, nothing will be changed on disk\n"
            SIMULATE='yes'
            ;;
        *)
            printf "Error: unknown argument: '%s'\n" "$1"
    esac
    shift
    test "$1" || break
done


# Shell
install_to_home "inputrc"
install_to_home "profile"
install_to_home "bashrc"
install_to_home "bash_profile"
install_to_config "aliasrc"

# Misc cli
install_to_home "tmux.conf"

# X
install_to_home "xinitrc"
install_to_home "Xresources"

# i3
install_to_config "i3/config"
install_to_config "i3status/config"

# Misc other
install_to_config "user-dirs.dirs"

# neovim
if confirm "Symlink nvim/* -> '$CONFIGDIR/nvim/*'?" ; then
    SKIP_PROMPT="yes"
    DOTPATHLEN="$(($(printf "%s" "$DOTPATH" | wc -c) + 2))"
    find "$DOTPATH/nvim" -type f | while read file; do
        printf "Symlinking '%s'...\n" "$file"
        install_to_config "$(printf "%s" "$file" | cut -c "$DOTPATHLEN-")" 
    done
    printf "...all done\n"
    SKIP_PROMPT=""
fi
