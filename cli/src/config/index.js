'use strict'

exports.homeDir = require('os').homedir()
// NOTE: This is the same as `this.config.configDir` inside a command function
exports.configDir = `${exports.homeDir}/.config/dotfiles`
exports.repoDir = `${exports.homeDir}/dotfiles`

