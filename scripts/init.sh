#!/bin/bash

SYS_NAME=$(uname)
YUM_PATH=/usr/bin/yum
APT_PATH=/usr/bin/apt-get
PAC_PATH=/usr/bin/pacman

if [ "${SYS_NAME}" == "Darwin" ]; then
  echo "Platform : Mac"
  bash ./scripts/distributions/Mac/init.sh $1
elif [ "${SYS_NAME}" == "Linux" ]; then
  echo "Platform : Linux"
  if [ -e ${YUM_PATH} ]; then
    echo "Package manager : yum"
    bash ./scripts/distributions/RedHat/init.sh $1
  elif [ -e ${APT_PATH} ]; then
    echo "Package manager : apt"
    bash ./scripts/distributions/Debian/init.sh $1
  elif [ -e ${PAC_PATH} ]; then
    echo "Package manager : pacman"
    bash ./scripts/distributions/Arch/init.sh $1
  else
    echo "Can not detect Linux package manager. Quitting... :("
  fi
else
  echo "Platform : Others. \nSupported platforms are Mac/RedHat/Debian/Arch. Quitting... :("
fi
