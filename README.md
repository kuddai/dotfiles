# Dotfiles
Stores my unix configuration files.

Using git bare repository [trick](https://www.atlassian.com/git/tutorials/dotfiles)
to store and update my configs.

TLDR version, using git bare with different work tree to track dotfiles in
$HOME. Also aliasing this special repo with *config* instead of *git*, and
storing it in *.cfg* instead of *.git* to avoid conflicts.

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

Also took some inspiration from this [repo](https://github.com/ibab/dotfiles).

# Installation

Using preexisting [snippet](https://gist.github.com/kuddai/d119010117035180b596e8faf2e8be25#file-dot-init-sh)

```bash
curl -Lks https://git.io/JeuMY | /bin/bash
```

# VIM

## Installation
Choose VIM with at least those compile flags (type *:vim --version* to check):
* +python
* +ruby

Then open *~/.vimrc* and type *:PlugInstall*

## Keyboard
Depending on the platform remap caps to escape.
Temporary solution on Unix:
```bash
setxkbmap -option "caps:escape"
```

To preserve it on each login search for native keyboard behaviors (works Mac OS X, Gnome) or [use](https://askubuntu.com/questions/363346/how-to-permanently-switch-caps-lock-and-esc)
```bash
sudo apt-get install dconf-tools
```
