# dotfiles

This is my MAC dotfiles repository :)

This repository build up with following tools:
- [ansible](http://www.ansible.com/home)
- [homesick](https://github.com/technicalpickles/homesick)
- [anyenv](https://github.com/riywo/anyenv)

### How to install

First, please install `Xcode` from Mac App Store or Apple Developer page.
Some package require Xcode environment to build their own.

Then, just type following command in your terminal.
```bash
curl -LSfs https://raw.githubusercontent.com/supistar/dotfiles/master/install.sh | bash
```

If you want to update packages which are described in YAML file, just type following command in your terminal :)
```bash
ansible-playbook macbook.yml -i hosts
```

