# dotfiles-minimal
A less wholistic set of dotfiles for work or container images

## Install Everything

```shell
./install.sh
```

## Install Individually

```console
dotfiles-lite on  feature/initial-tool-functions [!] 
⬢ [Docker] ❯ task --list
task: Available tasks for this project:
* install:all:          Install all tools, fonts, and dependencies after resetting the rc files
* setup:fzf:            Configure fzf and setup keybindings
* setup:starship:       Configure starship and customize it
* setup:vim:            Install vim, install vundle, & replace vimrc
* setup:zim:            Configure zim
* setup:zsh:            Configure zsh and replace zdot files
* tools:bat:            Install bat
* tools:bun:            Install bun
* tools:direnv:         Install direnv
* tools:eza:            Install eza
* tools:fd:             Install fd
* tools:fzf:            Install fzf
* tools:gcc:            Install gcc
* tools:gh:             Install gh
* tools:gomplate:       Install gomplate
* tools:ncdu:           Install ncdu
* tools:nmap:           Install nmap
* tools:nvm:            Install nvm
* tools:pyenv:          Install pyenv
* tools:ripgrep:        Install ripgrep
* tools:rsync:          Install rsync
* tools:sd:             Install sd
* tools:starship:       Install starship
* tools:vim:            Install vim
* tools:zim:            Install zim
* tools:zinit:          Install zinit
* tools:zoxide:         Install zoxide
* tools:zsh:            Install zsh
```

## Projects Used

* [gomplate](https://docs.gomplate.ca)
* [taskfiles](https://taskfiles.dev)
* [znap](https://github.com/marlonrichert/zsh-snap)