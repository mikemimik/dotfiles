# Dotfiles

My collection of dotfiles for all the tools I use in my day-to-day as a developer and macOS user.

## Dependencies
- Install [homebrew](https://brew.sh/) before installing this tool.
```shell
$ brew update
```
- An ssh key which is attached to your GitHub account needs to be active on the
machine.
```shell
# This should list out a key which is active in your GitHub account
$ ssh-add -l
```

## Install
With homebrew installed, install tap:
```shell
$ brew tap mikemimik/brew
```

On fresh installation of macOS:
```shell
xcode-select --install
```

Clone and install dotfiles:
```shell
$ git clone https://github.com/mikemimik/dotfiles.git ~/dotfiles
$ cd ~/dotfiles
$ ./setup.sh
```

### The `dotfiles` command (aka `dot-cli`)

```shell
$ dotfiles
￫ Usage: dot-cli <command>

Commands:
    help          This help message
    update        Update packages and pkg managers (OS, brew, node, npm)
    clean         Clean up caches (brew, npm)
    symlinks      Run symlinks script
    brew          Run brew script
    defaults      Run macOS defaults script
    dock          Run macOS dock script
```
