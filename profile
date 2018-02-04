#!/bin/sh
export HISTFILESIZE=50000
export HISTSIZE=50000

export EDITOR="nvim"

export PATH="$PATH:$HOME/bin:$HOME/.local/bin"

# tmux
if which tmux 2>&1 >/dev/null; then
    # if not inside a tmux session, and if no session
    # is started, start a new session
    export TERM=screen-256color
    test -z "$TMUX" && (tmux attach || tmux new-session)
fi
