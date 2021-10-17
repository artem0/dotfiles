export LANG=en_US.UTF-8

# Use ESC beside '^x^e' to edit the current command line:
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\033' edit-command-line

# Reduce delay time after pressing ESC before opening vim mode for editing a command
export KEYTIMEOUT=1
