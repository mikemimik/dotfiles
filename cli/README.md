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
$ npm install -g @mikemimik/dotfiles
$ dotfiles COMMAND
running command...
$ dotfiles (-v|--version|version)
@mikemimik/dotfiles/0.1.0 darwin-x64 node-v14.15.1
$ dotfiles --help [COMMAND]
USAGE
  $ dotfiles COMMAND
...
```
<!-- usagestop -->
# Commands
<!-- commands -->
* [`dotfiles help [COMMAND]`](#dotfiles-help-command)
* [`dotfiles symlinks`](#dotfiles-symlinks)

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

_See code: [src/commands/symlinks/index.js](https://github.com/mikemimik/dotfiles/blob/v0.1.0/src/commands/symlinks/index.js)_
<!-- commandsstop -->
