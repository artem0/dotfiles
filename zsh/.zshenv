export LANG=en_US.UTF-8

# folder with tools
export tools=$HOME/tools

# load python autocomplete
export PYTHONSTARTUP="$HOME/.pythonrc"

condaenv(){
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/artem/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
    eval "$__conda_setup"
    else
        if [ -f "/Users/artem/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/artem/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/artem/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
}

pythonenv() {
    # legacy python and pyspark
    alias python27=/usr/local/Cellar/python@2/2.7.17/bin/python2.7
    alias bp27="python27 -m bpython"
    alias bp="python3 -m bpython"
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

code() {
    open -a VSCodium $1
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
#export_brew_package "mtr" "sbin"


function hashcat {
	cd /usr/local/share/hashcat/OpenCL/
	/usr/local/bin/hashcat $@
	cd -
}
 
# import Python libs, maintain two versions 3.9 & 3.10, `pip3 list` & `pip3.9 list`
#export PATH=$HOME/Library/Python/2.7/bin/:$PATH
#export PATH=$HOME/Library/Python/3.7/bin/:$PATH
#export PATH=/usr/local/lib/python3.11/site-packages/:$PATH
#export PATH=$HOME/Library/Python/3.10/bin/:$PATH

export SDKMAN_DIR="$HOME/.sdkman"

# Use ESC beside '^x^e' to edit the current command line:
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\033' edit-command-line

# Reduce delay time after pressing ESC before opening vim mode for editing a command
export KEYTIMEOUT=1

