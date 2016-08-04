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
BRANCH=${1:-master}
curl -LSfs -O https://github.com/supistar/dotfiles/archive/${BRANCH}.zip
# Unzip
ARCHIVE="$(echo ${BRANCH} | awk -F/ '{print $NF}').zip"
unzip ${ARCHIVE}
DIRECTORY="dotfiles-$(echo ${BRANCH} | sed -e 's/\//-/g')"
cd ${DIRECTORY}
# Do install
sh ./scripts/init.sh $2
# Post-process
rm -rf ${TMP_DIR}/${DIRECTORY} ${TMP_DIR}/${ARCHIVE}
popd > /dev/null

echo "*** Installation completed! ***"

