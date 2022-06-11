export LANG=en_US.UTF-8

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# folder with tools
export tools=$HOME/tools

# load python autocomplete
export PYTHONSTARTUP="$HOME/.pythonrc"

pythonenv() {
    # necessary for virtual environments setup
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
    export WORKON_HOME=~/.virtualenvs
    [[ -s "/usr/local/bin/virtualenvwrapper.sh" ]] && source /usr/local/bin/virtualenvwrapper.sh
}

jsenv(){
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

rustenv() {
    . "$HOME/.cargo/env"
}

bigdataenv() {
    export CONFLUENT_HOME=$tools/confluent-5.3.0/
    export HADOOP_HOME=$tools/hadoop-2.9.1
    export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
    export HADOOP_CONF_PATH=$HADOOP_HOME/etc/hadoop
    export YARN_CONF_DIR=$HADOOP_HOME/etc/hadoop
}

jvmtool(){
    export PATH=$PATH:$tools/protoc-3.3.0-osx-x86_64/bin
    export PATH=$PATH:$tools/jvmtop-0.8.0
}


# Mac OS specific check for JAVA_HOME

if [ $(uname -s) = "Darwin" ]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
    export PATH=$JAVA_HOME/bin:$PATH
fi

export PATH="/usr/local/Cellar/openvpn/$(ls /usr/local/Cellar/openvpn | sort -r | head -n 1)/sbin:$PATH"
export PATH="/usr/local/Cellar/minikube/$(ls /usr/local/Cellar/minikube | sort -r | head -n 1)/bin:$PATH"

# import Python libs
#export PATH=$HOME/Library/Python/2.7/bin/:$PATH
#export PATH=$HOME/Library/Python/3.7/bin/:$PATH
export PATH=/usr/local/lib/python3.9/site-packages/:$PATH

export SDKMAN_DIR="$HOME/.sdkman"

# Use ESC beside '^x^e' to edit the current command line:
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\033' edit-command-line

# Reduce delay time after pressing ESC before opening vim mode for editing a command
export KEYTIMEOUT=1

