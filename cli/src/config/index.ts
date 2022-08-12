"use strict";

export const homeDir = require("os").homedir();
// NOTE: This is the same as `this.config.configDir` inside a command function
export const configDir = `${exports.homeDir}/.config/dotfiles`;
export const repoDir = `${exports.homeDir}/dotfiles`;
