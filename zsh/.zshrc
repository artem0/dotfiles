for file in ~/.zsh/*; do
  if [[ -f $file ]] ; then
    source $file
  fi
done

export ZSH=/$HOME/.oh-my-zsh

if [ ! -f $ZSH/oh-my-zsh.sh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

source $ZSH/oh-my-zsh.sh

 # source if a file exists
include () {[[ -f "$1" ]] && source "$1"}
#include ~/.nix-profile/etc/profile.d/nix.sh
include ~/.fzf.zsh
include ~/.sdkman/bin/sdkman-init.sh

# plugin autocomplete
autoload -Uz compinit; compinit
