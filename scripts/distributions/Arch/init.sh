#!/bin/sh

# Install basic packages
sudo pacman -Syy --noconfirm git base-devel python python-pip

# Set anyenv path
sh ./scripts/set-anyenv-path.sh bash_profile
# Reload profile
source ~/.bash_profile
# Install anyenv
sh ./scripts/install-anyenv.sh
# Install git-flow
sh ./scripts/distributions/Arch/install-gitflow.sh

# Update pip
pip install --upgrade pip
# Install ansible
pip install ansible

# Execute ansible
TARGET=${1:-default}
ansible-playbook ./playbooks/${TARGET}/arch.yml -i hosts

