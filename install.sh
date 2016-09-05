#!/bin/bash

TMP_DIR=/tmp

# Check Xcode.app and command line tools existence

if [ $(uname) == "Darwin" ]; then
    if [ ! -e "$(xcode-select -p)" ]; then
        echo "*** [Error] There is no Xcode.app, please install it first ***"
        exit 1
    fi

    if [ ! -e "$(xcrun --show-sdk-path)/usr/include/zlib.h" ]; then
        echo "*** [Error] There is no Xcode command line tools, please install it by `$ xcode-select --install` ***"
        exit 1

    fi
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
if [ -n "${TMP_DIR}" -a -n "${DIRECTORY}" -a -n "${TMP_DIR}/${ARCHIVE}" ]; then
    rm -rf "${TMP_DIR}/${DIRECTORY}" "${TMP_DIR}/${ARCHIVE}"
fi
popd > /dev/null

echo "*** Installation completed! ***"

