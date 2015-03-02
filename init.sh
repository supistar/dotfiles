#!/bin/sh

# Agree Xcode llcense
expect -c "
spawn sudo xcodebuild -license
expect \"Password\"
send -- \"YOUR_PASSWORD\n\"
expect \"MAC SDK AND XCODE AGREEMENT\"
send -- \"G\"
expect \"By typing 'agree'\"
send -- \"agree\n\"
"

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

# Install anyenv
sh ./scripts/install-anyenv.sh
# Set anyenv path
sh ./scripts/set-anyenv-path.sh bash_profile

# Execute ansible
ansible-playbook macbook.yml -i hosts

