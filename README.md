# dotfiles

This is my dotfiles repository :fire:

This repository build up with following tools:
- [ansible](http://www.ansible.com/home)
- [anyenv](https://github.com/riywo/anyenv)
- [homesick](https://github.com/technicalpickles/homesick)

### Supported environments

- Mac OSX
- RedHat Linux (Amazon Linux)
- Arch Linux

### Prerequisite

If you're using Mac environment, please install `Xcode` from Mac App Store or Apple Developer page.
Some package require Xcode environment to build their own.

### How to install

Just type following command in your terminal.
```bash
# Install normally
curl -LSfs https://raw.githubusercontent.com/supistar/dotfiles/master/install.sh | bash

or

# Install via specified branch (master) and machine type (ci)
curl -LSfs https://raw.githubusercontent.com/supistar/dotfiles/master/install.sh | xargs -I % bash % master ci
```

If you want to update packages which are described in YAML file, just type following command in your terminal :)
```bash
* Mac
ansible-playbook ./playbooks/default/macbook.yml -i hosts
* RedHat Linux (Amazon Linux)
ansible-playbook ./playbooks/default/redhat.yml -i hosts -K
* Arch Linux
ansible-playbook ./playbooks/default/arch.yml -i hosts -K
```

