#!/bin/sh

PLUGINS=( \
    "_libly.js" \
    "bitly.js" \
    "asdfghjkl.js" \
    "copy.js" \
    "direct_bookmark.js" \
    "feedSomeKeys_3.js" \
    "hatenaStar.js" \
    "migemized_find.js" \
    "prevent_focus_ietab.js" \
    "sbmcommentsviewer.js" \
    "xpath_hint.js" \
    "readitlater.js" \
    )

for plugin in "${PLUGINS[@]}"; do
    wget -O ${plugin} https://raw.githubusercontent.com/vimpr/vimperator-plugins/master/${plugin} --no-check-certificate
done

