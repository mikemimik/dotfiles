'use strict'

/**
 * Configuration Defaults
 *
 */

exports.homeDir = require('os').homedir()
exports.configFile = 'details.json'
exports.configDir = `${exports.homeDir}/.config/dotfiles`
exports.repoDir = `${exports.homeDir}/dotfiles`
exports.dotDir = 'install'
