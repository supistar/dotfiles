#!/bin/bash

# Update apt
sudo apt update

# Install basic packages
sudo apt install -y git patch
# Install packages for building ruby
sudo apt install -y libreadline-dev
# Install packages for building python
sudo apt install -y build-essential libgmp-dev libncursesw5-dev libssl-dev libsqlite3-dev libgdbm-dev libbz2-dev liblzma-dev zlib1g-dev uuid-dev libffi-dev libdb-dev

# Configure git global config
bash ./scripts/set-git-global-config.sh
# Set anyenv path
bash ./scripts/set-anyenv-path.sh bash_profile
# Reload profile
. ~/.bash_profile
# Install anyenv
bash ./scripts/install-anyenv.sh
# Reload profile
. ~/.bash_profile

# Update pip
pip install --upgrade pip
# Install ansible
pip install ansible

# Execute ansible
TARGET=${1:-default}
ansible-playbook ./playbooks/${TARGET}/debian.yml -i hosts

