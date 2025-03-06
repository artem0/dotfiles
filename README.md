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
stow vim -t ~/
stow nvim -t ~/.config/nvim/
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

### Performance tuning
```bash
for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done

zsh -i -c -x exit &> logs.txt
```

https://gist.github.com/elalemanyo/cb3395af64ac23df2e0c3ded8bd63b2f
At the beginning of your .zshrc add following: `zmodload zsh/zprof`
and at the end add: `zprof`