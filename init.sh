#!/bin/sh

# Agree Xcode llcense
expect -c "
spawn sudo xcodebuild -license
expect \"Password\"
send -- \"YOUR_PASSWORD\n\"
expect \"You have not agreed to the Xcode license agreements\"
send -- \"\n\"
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

# Set anyenv path
sh ./scripts/set-anyenv-path.sh bash_profile
# Install anyenv
sh ./scripts/install-anyenv.sh

# Tap versions (homebrew and caskroom)
brew tap homebrew/versions
brew tap caskroom/versions

# Execute ansible
ansible-playbook macbook.yml -i hosts

