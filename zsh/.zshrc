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

# Completions
# Explicitly load kubectl/docker completion; kubectl/docker from ohmyzsh plugins arrays create useless `k*/d*`-like aliases; zinit duplicates it in cache ~/.cache/zinit/completions/_docker
# these commands need kubectl/docker in $PATH, so they are below homebrew $PATH import; alternatively - put $PATH modifications right at the top of the .zshrc file - https://github.com/ohmyzsh/ohmyzsh/issues/12295#issuecomment-2013498069
[[ -x $(command -v kubectl) ]] && source <(kubectl completion zsh)
[[ -x $(command -v docker) ]] && source <(docker completion zsh)
[[ -x $(command -v fd) ]] && source <(fd --gen-completions zsh)

# workaround for failed command: source <(rg --generate complete-zsh)
if command -v rg >/dev/null 2>&1; then
  _rg() {
    eval "$(rg --generate complete-zsh)"
  }
  compdef _rg rg
fi

# the version is stored in ~/.python-version and ~/.pyenv/version - edit this file manually, as `pyenv global <python-version>` doesn't work
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# flags to make alias to autojump's j - https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#flags
eval "$(zoxide init zsh --cmd j)"

# Intellij Launcher
export PATH="$PATH:/Applications/IntelliJ IDEA CE.app/Contents/MacOS"

# Amp CLI
export PATH="/Users/artem/.amp/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
