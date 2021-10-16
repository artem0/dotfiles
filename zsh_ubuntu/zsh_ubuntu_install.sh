pretty_print() {
    GREEN='\033[0;32m'
    NOCOLOR='\033[0m'
    printf "${GREEN}$@${NOCOLOR}\n"
}

DOTFILES_FOLDER="$HOME/dotfiles"
DOTFILES_URL=https://github.com/artem0/dotfiles.git

pretty_print "Installing zsh and dependencies"
yes | sudo apt install zsh
yes Y | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
yes | sudo apt-get install stow
yes | curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
yes | sudo apt-get install fzf
yes | sudo apt install autojump
pretty_print "Necessary packages are installed, applying dotflies"
rm ~/.zshrc

if [ ! -d $DOTFILES_FOLDER/.git ]
    then git clone $DOTFILES_URL $DOTFILES_FOLDER
    pretty_print "Cloning dotfiles repo"
else
    cd $DOTFILES_FOLDER || exit
    git pull $DOTFILES_URL
    pretty_print "Pulling from dotfiles repo"
fi

cd "$DOTFILES_FOLDER/zsh_ubuntu" || exit
stow zsh -t $HOME
chsh -s "$(which zsh)"
pretty_print "Done"
