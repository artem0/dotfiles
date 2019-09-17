for file in ~/.zsh/*; do
  if [[ -f $file ]] ; then
    source $file
  fi
done

export ZSH=/$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
