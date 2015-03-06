#!/bin/bash

TMP_DIR=/tmp

# Check Xcode.app existence
if [ ! -e "/Applications/Xcode.app" ]; then
    echo "*** [Error] There is no Xcode.app, please install it first***"
    exit 1
fi

echo "*** Installation start ***"

# Move to temporary dir
pushd ${TMP_DIR} > /dev/null
# Download dotfiles from master
curl -LSfs -O https://github.com/supistar/dotfiles/archive/master.zip
# Unzip
unzip master.zip
cd dotfiles-master
# Do install
sh ./scripts/init.sh
# Post-process
rm -rf ${TMP_DIR}/dotfiles-master ${TMP_DIR}/master.zip
popd > /dev/null

echo "*** Installation completed! ***"

