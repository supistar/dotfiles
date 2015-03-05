#!/bin/sh

ANYENV_INSTALL=$(printenv | grep anyenv | wc -l | xargs echo)

if test ${ANYENV_INSTALL} -gt 0; then
  echo "Anyenv is already installed, quitting... :)"
  exit 1
fi

if test "$1" != "bash_profile" -a "$1" != "zshrc"; then
  echo "Argument looks wrong, please specify bash_profile or zshrc"
  exit 2
fi


# Set exports
echo '' >> ~/.$1
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.$1
echo 'eval "$(anyenv init -)"' >> ~/.$1
echo 'for D in `ls $HOME/.anyenv/envs`' >> ~/.$1
echo 'do' >> ~/.$1
echo '  export PATH="$HOME/.anyenv/envs/$D/shims:$PATH" ' >> ~/.$1
echo 'done' >> ~/.$1

# Reload
exec $SHELL -l
