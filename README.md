dotfiles
========

Managed by [GNU Stow][].

[GNU Stow]: https://www.gnu.org/software/stow/

Installation
------------

The `stow` creates a symlink for files in the parent directory of where the installation command is executed.
For instance, if cloned repo is in home dir `~/dotfiles`, `stow` will make symlink in `~/.vimrc`, `~/zshrc`  and so on.

In otherwise case, directory location with this repos should be specified as a flag: `stow baz -d ~/foo/bar/dotfiles`, 
or it should be executed from `dotfiles` folder - but specifying of the destination is required: `stow zsh -t ~`

```bash
cd ~

git clone https://github.com/artem0/dotfiles

cd dotfiles

stow zsh
stow vim
```
