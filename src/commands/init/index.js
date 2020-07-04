'use strict'

const { Command, Definition } = require('@mikemimik/command')
const spawn = require('@npmcli/promise-spawn')
const { resolve, basename, dirname, normalize } = require('path')
const { promisify } = require('util')
const mkdirp = require('mkdirp')
const which = require('which')
const fs = require('fs')
const writefile = promisify(fs.writeFile)
const readfile = promisify(fs.readFile)
const readlink = promisify(fs.readlink)
const readdir = promisify(fs.readdir)
const symlink = promisify(fs.symlink)
const lstat = promisify(fs.lstat)

const { configDir, repoDir, dotDir, homeDir } = require('../../config')

class InitCommand extends Command {
  async initialize () {
    this.logger.silly(this.name, 'initialize')
    // TODO: check to see if the dotfiles repo is already initialized
    try {
      const stat = await lstat(`${configDir}`)
      console.log(stat)
      // INFO: the directory already exists, we've `init` before
      // NOTE: if things are messy, use `doctor` command
      return false
    } catch (e) {
      if (e.code === 'ENOENT') {
        // INFO: folder doesn't exist
        return true
      }
      this.logger.error(e)
      return false
    }
  }

  async installHomebrew () {
    try {
      this.logger.notice('Checking for Homebrew...')
      await which('brew')
    } catch (e) {
      // NOTE: brew not installed
      this.logger.info('Installing Homebrew...')
      const rubyPath = which('ruby')
      const args = [
        '-e',
        '"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
      ]
      await spawn(rubyPath, args)
    }
  }

  async brewCmd (args) {
    const brewPath = await which('brew')
    const result = await spawn(brewPath, args, {
      stdioString: true
    })
    return result.stdout
  }

  async updateBrew () {
    this.logger.notice('Updating Homebrew...')
    try {
      await this.brewCmd(['update'])
    } catch (e) {
      // INFO: update failed; yell about it
      this.logger.error('Failed to update brew')
    }
  }

  async listBrews () {
    // TODO: wrap in try/catch
    this.logger.silly('Fetching list of current brews...')
    const result = await this.brewCmd([ 'list' ])
    return result.split('\n')
  }

  async installTaps () {
    this.logger.silly('Installing taps...')
    const tapPath = resolve(repoDir, dotDir, 'taps.json')
    const data = await readfile(tapPath, 'utf8')
    const taps = JSON.parse(data)
    for (let x = 0; x < taps.length; x++) {
      try {
        await this.brewCmd(['tap', taps[x]])
      } catch (e) {
        this.logger.error('TAP', `Failed to install tap: ${taps[x]}`)
      }
    }
  }

  async installBrews () {
    try {
      const listpath = resolve(repoDir, dotDir, 'brews.json')
      const data = await readfile(listpath, 'utf8')
      const brews = JSON.parse(data)

      const currentList = await this.listBrews()

      for (let x = 0; x < brews.length; x++) {
        if (!currentList.includes(brews[x])) {
          try {
            const brewArgs = [ 'install', brews[x] ]
            const result = await this.brewCmd(brewArgs)
            // TODO: parse output from 'brew install'; could be useful to display
            console.log(result)
          } catch (e) {
            // INFO: failed to install brew; catch here, no interupt installs
            const msg = e.stderr.split('\n')[0]
            this.logger.error('BREW', `Failed to install formula: ${brews[x]}`)
            this.logger.error('BREW', msg)
          }
        }
        this.logger.info('BREW', `Skipping, ${brews[x]}, already installed...`)
      }
    } catch (e) {
      // TODO: handle JSON parse error
      // TODO: handle 'no brew' error
      // TODO: handle readfile error
      console.error('something blew up')
      console.error(e)
    }
  }

  async installCasks () {
    try {
      const listpath = resolve(repoDir, dotDir, 'casks.json')
      const data = await readfile(listpath, 'utf8')
      const casks = JSON.parse(data)

      const currentList = await this.brewCmd(['cask', 'list'])

      // INFO: install cask apps
      for (let x = 0; x < casks.apps.length; x++) {
        if (!currentList.includes(casks.apps[x])) {
          try {
            const caskArgs = ['cask', 'install', casks.apps[x]]
            const result = await this.brewCmd(caskArgs)
            // TODO: parse output from 'brew install'; could be useful to display
            console.log(result)
          } catch (e) {
            // INFO: failed to install brew; catch here, no interupt installs
            const msg = e.stderr.split('\n')[0]
            this.logger.error('CASK', `Failed to install formula: ${casks.apps[x]}`)
            this.logger.error(msg)
          }
        }
        this.logger.info('CASK', `Skipping, ${casks.apps[x]}, already installed...`)
      }

      // INFO: install casks; require user action
      try {} catch (e) {}

      // INFO: install casks; require system dialog accept
      try {} catch (e) {}
    } catch (e) {
      // TODO: handle JSON parse error
      // TODO: handle 'no brew' error
      // TODO: handle readfile error
      console.error('something blew up')
      console.error(e)
    }
  }

  async symlinkDots () {
    try {
      const listpath = resolve(repoDir, 'dots')
      const files = await readdir(listpath, 'utf8')
      console.log(files)
      for (let x = 0; x < files.length; x++) {
        const file = files[x]
        await symlink(`${listpath}/${file}`, `${homeDir}/${file}`)
      }
    } catch (e) {
      console.error('something blew up')
      console.error(e)
    }
  }

  async execute () {
    this.logger.silly(this.name, 'execute')
    // TODO: determine what it means to initialize 'dotfiles'
    /**
     * The repository would already be cloned. Presumably `npm i` would be run.
     * Want to run through the install scripts.
     * - dots
     * - clean up `brew cleanup` / `npm cache clean`
     * - macos settings (requrires restart)
     * - apps
     */
    try {
      // TODO: make the config directory
      // TODO: find where the repo is closed to; so we know where the data is
      // TODO: install brews
      await this.installHomebrew()
      await this.updateBrew()
      await this.installTaps()
      await this.installBrews()
      await this.installCasks()
      await this.symlinkDots()
    } catch (e) {
      console.error(e)
    }
  }
}

const definition = new Definition({
  command: 'init',
  describe: 'Init command initialises environment for dotfiles.',
  builder: (yargs) => {
    return yargs
  },
  commandClass: InitCommand
})

module.exports = definition
module.exports.InitCommand = InitCommand
