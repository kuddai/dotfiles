#!/bin/bash -x
# -x -v print verbose lines for each command, makes debugging easier.

function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

echo "Creating .config-backup dir."
mkdir -p .config-backup
echo "Checking dotfiles from repo."
config checkout
if [ $? = 0 ]; then
  echo "Checked out config with backup.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
