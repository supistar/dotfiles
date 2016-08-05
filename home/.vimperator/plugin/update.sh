#!/bin/sh

PLUGINS=( \
    "_libly.js" \
    "bitly.js" \
    "copy.js" \
    "direct_bookmark.js" \
    "feedSomeKeys_3.js" \
    "hatenaStar.js" \
    "sbmcommentsviewer.js" \
    "readitlater.js" \
    )
#PLUGINS+=(
#    "asdfghjkl.js" \
#    "migemized_find.js" \
#    "prevent_focus_ietab.js" \
#    "xpath_hint.js" \
#)

SCRIPT_DIR=`dirname $0`
pushd ${SCRIPT_DIR}

# Download plugins
for plugin in "${PLUGINS[@]}"; do
    wget -O ${plugin} https://raw.githubusercontent.com/vimpr/vimperator-plugins/master/${plugin} --no-check-certificate
done

popd
