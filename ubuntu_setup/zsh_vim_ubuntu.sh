pretty_print() {
    GREEN='\033[0;32m'
    NOCOLOR='\033[0m'
    printf "${GREEN}$@${NOCOLOR}\n"
}

DOTFILES_FOLDER="$HOME/dotfiles"
DOTFILES_URL=https://github.com/artem0/dotfiles.git

pretty_print "Installing zsh and dependencies"
yes | sudo apt install zsh
yes | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
yes | sudo apt-get install stow
yes | curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
yes | sudo apt-get install silversearcher-ag
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

cd "$DOTFILES_FOLDER/ubuntu_setup" || exit
stow zsh -t $HOME
chsh -s "$(which zsh)"
pretty_print "ZSH is installed"

# installing fzf manually for vim - wacky w\o the setup below
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install
cd $DOTFILES_FOLDER || exit
stow vim -t $HOME
pretty_print "VIMRC is applied"

sudo snap install lnav
sudo apt install net-tools
pretty_print "Installed lnav and netstat"
pretty_print "Done!"
