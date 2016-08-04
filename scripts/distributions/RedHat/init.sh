#!/bin/sh

# Update yum
sudo yum update

# Install basic packages
sudo yum install -y git patch
# Install packages for building ruby
sudo yum install -y readline-devel
# Install packages for building python
sudo yum install -y gmp gmp-devel

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

# Execute ansible
TARGET=${1:-default}
ansible-playbook ./playbooks/${TARGET}/redhat.yml -i hosts

