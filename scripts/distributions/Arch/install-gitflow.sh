#!/bin/sh

cd /usr/local/src
wget -q -O - --no-check-certificate https://github.com/nvie/gitflow/raw/develop/contrib/gitflow-installer.sh | sudo bash

