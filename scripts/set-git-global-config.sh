#!/bin/bash

if [ $(uname -r) == *"microsoft"* ]; then
  git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager.exe"
fi
