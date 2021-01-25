dotfiles
========

Dotfiles CLI Tool

[![oclif](https://img.shields.io/badge/cli-oclif-brightgreen.svg)](https://oclif.io)
[![Version](https://img.shields.io/npm/v/dotfiles.svg)](https://npmjs.org/package/dotfiles)
[![Codecov](https://codecov.io/gh/mikemimik/dotfiles/branch/master/graph/badge.svg)](https://codecov.io/gh/mikemimik/dotfiles)
[![Downloads/week](https://img.shields.io/npm/dw/dotfiles.svg)](https://npmjs.org/package/dotfiles)
[![License](https://img.shields.io/npm/l/dotfiles.svg)](https://github.com/mikemimik/dotfiles/blob/master/package.json)

<!-- toc -->
* [Usage](#usage)
* [Commands](#commands)
<!-- tocstop -->
# Usage
<!-- usage -->
```sh-session
$ npm install -g dotfiles
$ dotfiles COMMAND
running command...
$ dotfiles (-v|--version|version)
dotfiles/0.0.0 darwin-x64 node-v14.15.1
$ dotfiles --help [COMMAND]
USAGE
  $ dotfiles COMMAND
...
```
<!-- usagestop -->
# Commands
<!-- commands -->
* [`dotfiles brew:update`](#dotfiles-brewupdate)
* [`dotfiles hello`](#dotfiles-hello)
* [`dotfiles help [COMMAND]`](#dotfiles-help-command)
* [`dotfiles init`](#dotfiles-init)
* [`dotfiles symlinks`](#dotfiles-symlinks)

## `dotfiles brew:update`

Update list of brew formulas that are stored in the dotfiles repo with

```
USAGE
  $ dotfiles brew:update

DESCRIPTION
  the currently installed formula on this machine.

EXAMPLE
  $ dotfiles brew:update
```

_See code: [src/commands/brew/update.js](https://github.com/mikemimik/dotfiles/blob/v0.0.0/src/commands/brew/update.js)_

## `dotfiles hello`

Describe the command here

```
USAGE
  $ dotfiles hello

OPTIONS
  -n, --name=name  name to print

DESCRIPTION
  ...
  Extra documentation goes here
```

_See code: [src/commands/hello.js](https://github.com/mikemimik/dotfiles/blob/v0.0.0/src/commands/hello.js)_

## `dotfiles help [COMMAND]`

display help for dotfiles

```
USAGE
  $ dotfiles help [COMMAND]

ARGUMENTS
  COMMAND  command to show help for

OPTIONS
  --all  see all commands in CLI
```

_See code: [@oclif/plugin-help](https://github.com/oclif/plugin-help/blob/v3.2.1/src/commands/help.ts)_

## `dotfiles init`

```
USAGE
  $ dotfiles init
```

_See code: [src/commands/init.js](https://github.com/mikemimik/dotfiles/blob/v0.0.0/src/commands/init.js)_

## `dotfiles symlinks`

Create symlinks between files in the home directory, and the symlinks kept

```
USAGE
  $ dotfiles symlinks

OPTIONS
  -f, --force  force symlink creation

DESCRIPTION
  in the dotfiles repository. These relationships can be found in the
  config/symlinks.json file.

EXAMPLES
  $ dotfiles symlinks
  $ dotfiles symlinks --force
```

_See code: [src/commands/symlinks/index.js](https://github.com/mikemimik/dotfiles/blob/v0.0.0/src/commands/symlinks/index.js)_
<!-- commandsstop -->
