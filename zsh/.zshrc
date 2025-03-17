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
#include ~/.fzf.zsh
include ~/.sdkman/bin/sdkman-init.sh

# plugin autocomplete
autoload -Uz compinit; compinit

export PATH="/opt/homebrew/bin:$PATH"

# Explicitly load kubectl/docker completion; kubectl/docker from ohmyzsh plugins arrays create useless `k*/d*`-like aliases; zinit duplicates it in cache ~/.cache/zinit/completions/_docker
# these commands need kubectl/docker in $PATH, so they are below homebrew $PATH import; alternatively - put $PATH modifications right at the top of the .zshrc file - https://github.com/ohmyzsh/ohmyzsh/issues/12295#issuecomment-2013498069
if command -v kubectl >/dev/null 2>&1; then
    source <(kubectl completion zsh)
fi
if command -v docker >/dev/null 2>&1; then
    source <(docker completion zsh)
fi

# the version is stored in ~/.python-version
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# flags to make alias to autojump's j - https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#flags
eval "$(zoxide init zsh --cmd j)"