#!/bin/sh

# Clone anyenv
git clone https://github.com/riywo/anyenv ~/.anyenv

# Add PATH
export PATH="$HOME/.anyenv/bin:$PATH"

# Install
eval "$(anyenv init -)"
#mkdir ${HOME}/.anyenv/envs
anyenv install -f rbenv
anyenv install -f pyenv
anyenv install -f ndenv

rbenv install 2.2.0
ndenv install v0.10.36
pyenv install 2.7.9

rbenv global 2.2.0
ndenv global v0.10.36
pyenv global 2.7.9

# Reload
exec $SHELL -l

