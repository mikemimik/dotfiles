# Dotfiles

My collection of dotfiles for all the tools I use in my day-to-day as a developer and macOS user.

## Dependencies

- Install [homebrew](https://brew.sh/) before installing this tool.

## Install

1. Clone and install dotfiles:

```shell
git clone https://github.com/mikemimik/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

2. Install applictaions with homebrew:

```shell
brew bundle install --no-quarantine
```

3. Setup 1password sshkey agent

4. Run `setup.sh`

```shell
./setup.sh
```

5. Run `macos/defaults.sh` script

```shell
./macos/defaults.sh
```

6. Individual application setups:

- Dropbox
- Alfred
  - Configuration lives in Dropbox
  - Disable spotlight keyboard shortcuts
- Bartender
- Karabiner
- Hammerspoon
