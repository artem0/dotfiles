export LANG=en_US.UTF-8

# folder with tools
export tools=$HOME/tools

# load python autocomplete
export PYTHONSTARTUP="$HOME/.pythonrc"

pythonenv() {
    # legacy python and pyspark
    alias python27=/usr/local/Cellar/python@2/2.7.17/bin/python2.7
    alias bp="python27 -m bpython"
    alias bps="PYSPARK_DRIVER_PYTHON=bpython pyspark" # $HOME/Library/Python/2.7/bin/bpython for 2.7
    alias jupyter_pyspark="PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS=notebook pyspark"
    alias pyfind='find . -name "*.py"'
    alias pygrep='grep -r --color --include="*.py"'

    # virtual environments setup
    export VIRTUALENVWRAPPER_PYTHON=$(which python3)
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

goenv() {
    export PATH=$PATH:~/go/bin
}

# Mac OS specific check for JAVA_HOME
if [ $(uname -s) = "Darwin" ]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
    export PATH=$JAVA_HOME/bin:$PATH
fi

export_brew_package() {
    package=$1
    sub_path=$2
    package_path=/usr/local/Cellar/"$package"
    latest_version=$(ls "$package_path" | sort -r | head -n 1)
    export PATH="$package_path/$latest_version/$sub_path:$PATH"
}

export_brew_package "openvpn" "sbin"
export_brew_package "mtr" "sbin"

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


rustenv
