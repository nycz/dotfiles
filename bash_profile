#!/bin/bash

# this is executed when logging in, by tty or ssh
# include bashrc and profile if they exist
test -r ~/.bashrc && . ~/.bashrc
test -r ~/.profile && . ~/.profile
