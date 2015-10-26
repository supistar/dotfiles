#!/bin/sh

# Update yum
sudo yum update

# Install basic packages
sudo pacman -S git base-devel python2

# Set anyenv path
sh ./scripts/set-anyenv-path.sh bash_profile
# Reload profile
source ~/.bash_profile
# Install anyenv
sh ./scripts/install-anyenv.sh

# Update pip
pip install --upgrade pip
# Install ansible
pip install ansible

# Create simlink for python (avoid gem error)
sudo ln -sf /usr/bin/python2 /usr/bin/python

# Execute ansible
ansible-playbook ./playbooks/arch.yml -i hosts

