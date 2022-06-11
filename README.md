                ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
                ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
                ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
                ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
                ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
                ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
                
                               For macOS/Linux distribution


Managed by [GNU Stow][].

[GNU Stow]: https://www.gnu.org/software/stow/

### Installation

The `stow` creates a symlink for files in the parent directory of where the installation command is executed.
For instance, if the cloned repo is in home dir `~/dotfiles`, `stow` will make symlink in `~/.vimrc`, `~/zshrc`  and so on.

Otherwise, the directory location should be specified: `stow baz -d ~/foo/bar/dotfiles`, 
or it should be executed from the `dotfiles` folder: `cd /foo/bar/dotfiles && stow zsh -t ~/`

```bash
cd ~
git clone https://github.com/artem0/dotfiles
cd dotfiles

stow zsh
stow vim
```

Apply changes:
```bash
j dotfiles
stow zsh -t ~/
```

### Setting up macOS defaults:

```bash
cd macos && ./.macos
```

### Install Homebrew formulae

```bash
cd macos && ./brew.sh
```

