#!/bin/sh

# Agree Xcode llcense
sudo xcodebuild -license

# Install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

# Update homebrew
brew install git
brew update

# Install ansible and roles
brew install ansible
ansible-galaxy install hnakamur.homebrew-packages
ansible-galaxy install hnakamur.homebrew-cask-packages

# Set anyenv path
sh ./scripts/set-anyenv-path.sh bash_profile
# Reload profile
source ~/.bash_profile
# Install anyenv
sh ./scripts/install-anyenv.sh

# Execute ansible
TARGET=${1:-default}
ansible-playbook ./playbooks/${TARGET}/macbook.yml -i hosts

