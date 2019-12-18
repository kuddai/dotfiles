unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [ -r ~/.bashrc ]; then
   source ~/.bashrc
fi


# https://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion
if [ "$machine" == "Mac"]; then
  [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
fi

if [ "$machine" == "Linux"]; then
  if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
  . /opt/local/etc/profile.d/bash_completion.sh
  fi
fi

export PATH="/usr/local/opt/ruby/bin:$PATH"
