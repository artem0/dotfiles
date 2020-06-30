export LANG=en_US.UTF-8

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# folder with tools
export tools=$HOME/tools

# load python autocomplete
export PYTHONSTARTUP="$HOME/.pythonrc"

# necessary for virtual environments setup
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
export WORKON_HOME=~/.virtualenvs
[[ -s "/usr/local/bin/virtualenvwrapper.sh" ]] && source /usr/local/bin/virtualenvwrapper.sh

export SPARK_HOME=$tools/spark-2.4.4-bin-hadoop2.7/
export PATH="$SPARK_HOME/bin:$PATH"
export PYTHONPATH=$SPARK_HOME/python

export CONFLUENT_HOME=$tools/confluent-5.3.0/

# Hadoop
export HADOOP_HOME=$tools/hadoop-2.9.1
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_CONF_PATH=$HADOOP_HOME/etc/hadoop
export YARN_CONF_DIR=$HADOOP_HOME/etc/hadoop

# Mac OS specific check for JAVA_HOME

if [ $(uname -s) = "Darwin" ]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
    export PATH=$JAVA_HOME/bin:$PATH
fi

export PATH="/usr/local/Cellar/openvpn/2.4.6/sbin:$PATH"

# import Python libs
export PATH=$HOME/Library/Python/2.7/bin/:$PATH
export PATH=$HOME/Library/Python/3.7/bin/:$PATH

export PATH=$PATH:$tools/protoc-3.3.0-osx-x86_64/bin
export PATH=$PATH:$tools/jvmtop-0.8.0

export SDKMAN_DIR="$HOME/.sdkman"

# Reduce delay time after pressing ESC before opening vim mode for editing a command
export KEYTIMEOUT=1
