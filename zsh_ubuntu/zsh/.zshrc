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
include ~/.fzf.zsh

# removes a "partial line" 
unsetopt PROMPT_SP
