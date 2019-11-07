# Dotfiles
Unix configuration files:
* Use [git bare repository](https://www.atlassian.com/git/tutorials/dotfiles) with different work tree to track dotfiles in **$HOME**.
* Store repository information in the **.cfg** folder instead of **.git** to avoid conflicts.
* Make **config** alias for **git** command pointing to this repository for easier usage.

Bash script:
```bash
# Bare repository.
git init --bare $HOME/.cfg
# Alias to *config*
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# Don't show files as untracked in status unless explicitly added.
config config --local status.showUntrackedFiles no
# Save alias in .bashrc for persistency.
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

Inspired by [this](https://github.com/ibab/dotfiles).

# Installation

Use preexisting [snippet](https://gist.githubusercontent.com/kuddai/d119010117035180b596e8faf2e8be25/raw/876e8ad3df15138c624e80726a3235d3758fd582/dot-init.sh)

```bash
curl -Lks https://git.io/JeuMY | /bin/bash
```

# VIM

## Installation
Choose VIM with at least those compile flags (type **:vim --version** to check):
* +python
* +ruby

Then open **~/.vimrc** and type **:PlugInstall**

## Keyboard
Depending on the platform remap caps to escape.
Temporary solution on Unix:
```bash
setxkbmap -option "caps:escape"
```

To make it persistent look for ["how to change native keyboard bindings"](https://askubuntu.com/questions/363346/how-to-permanently-switch-caps-lock-and-esc). By default it can be easiliy adjusted on Mac OS X or on some linux distributives, e.g. Gnome.
```bash
sudo apt-get install dconf-tools
```
