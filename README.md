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

```bash
git clone --bare git@github.com:kuddai/dotfiles.git $HOME/.cfg
./kuddai-dot-files-install.sh
```

# TODO
Script to install all dependencies depending on whether it is Mac OS X or Linux.

# VIM

## Installation
It requires ruby, python, cmake, make, g++, node and npm.
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
