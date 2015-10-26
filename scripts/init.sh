#!/bin/sh

SYS_NAME=$(uname)
YUM_PATH=/usr/bin/yum
APT_PATH=/usr/bin/apt-get
PAC_PATH=/usr/bin/pacman

if test "${SYS_NAME}" == "Darwin"; then
  echo "Platform : Mac"
  sh ./scripts/distributions/Mac/init.sh
elif test "${SYS_NAME}" == "Linux"; then
  echo "Platform : Linux"
  if test -e ${YUM_PATH}; then
    echo "Package manager : yum"
    sh ./scripts/distributions/RedHat/init.sh
  elif test -e ${APT_PATH}; then
    echo "Package manager : apt"
    sh ./scripts/distributions/Debian/init.sh
  elif test -e ${PAC_PATH}; then
    echo "Package manager : pacman"
    sh ./scripts/distributions/Arch/init.sh
  else
    echo "Can not detect Linux package manager. Quitting... :("
  fi
else
  echo "Platform : Others. \nSupported platforms are Mac/RedHat/Debian/Arch. Quitting... :("
fi
