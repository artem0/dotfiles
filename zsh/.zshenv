export LANG=en_US.UTF-8

# folder with tools
export tools=$HOME/tools

# load python autocomplete
export PYTHONSTARTUP="$HOME/.pythonrc"

pv() {
    # legacy python and pyspark
    # alias python27=/usr/local/Cellar/python@2/2.7.17/bin/python2.7
    # alias bp27="python27 -m bpython"
    # alias bps="PYSPARK_DRIVER_PYTHON=bpython pyspark" # $HOME/Library/Python/2.7/bin/bpython for 2.7
    # alias jupyter_pyspark="PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS=notebook pyspark"
    # alias pyfind='find . -name "*.py"'
    # alias pygrep='grep -r --color --include="*.py"'

    alias bp="python -m bpython"

    # virtual environments setup; check python or python3
    export VIRTUALENVWRAPPER_PYTHON=$(which python)
    export WORKON_HOME=~/.virtualenvs
    # source $(which virtualenvwrapper.sh) # virtualenvwrapper.sh crashes shell
    source $(pyenv root)/versions/$(pyenv version-name)/bin/virtualenvwrapper.sh

    # Created by `pipx`
    export PATH="$PATH:~/.local/bin"
}

jsenv(){
    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
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

export_brew_package() {
    local package="$1"
    local package_path="/opt/homebrew/opt/${package}"
    local bin_path="${package_path}/bin"
    local sbin_path="${package_path}/sbin"

    # Check sbin first, then bin, and export directly
    if [[ -d "$sbin_path" ]]; then
        export PATH="${sbin_path}:${PATH}"
    elif [[ -d "$bin_path" ]]; then
        export PATH="${bin_path}:${PATH}"
    else
        echo "Warning: Neither '${bin_path}' nor '${sbin_path}' exists" >&2
        return 1
    fi
}

# export_brew_package "openvpn"
# export_brew_package "mtr"

function hashcat {
	cd /usr/local/share/hashcat/OpenCL/
	/usr/local/bin/hashcat $@
	cd -
}
 
# Legacy imports for Python libs, maintain two versions 3.9 & 3.10, `pip3 list` & `pip3.9 list`
#export PATH=$HOME/Library/Python/2.7/bin/:$PATH
#export PATH=$HOME/Library/Python/3.7/bin/:$PATH
#export PATH=/usr/local/lib/python3.11/site-packages/:$PATH
#export PATH=$HOME/Library/Python/3.11/bin/:$PATH

export SDKMAN_DIR="$HOME/.sdkman"

# Ctrl-q beside Ctrl-x-Ctrl-e' to edit the current line in vim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^q' edit-command-line
export EDITOR='nvim'
export VISUAL='nvim'

# Reduce delay time after pressing ESC before opening vim mode for editing a command
export KEYTIMEOUT=1

