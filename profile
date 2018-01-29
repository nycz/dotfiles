#!/bin/sh
export HISTFILESIZE=50000
export HISTSIZE=50000

export EDITOR="nvim"

export PATH="$PATH:$HOME/bin:$HOME/.local/bin"

export CLOUDSDK_ROOT_DIR="$HOME/builds/google-cloud-sdk"
export CLOUDSDK_PYTHON=python2
export CLOUDSDK_PYTHON_ARGS=-S
export PATH=$CLOUDSDK_ROOT_DIR/bin:$PATH
export GOOGLE_CLOUD_SDK_HOME=$CLOUDSDK_ROOT_DIR
