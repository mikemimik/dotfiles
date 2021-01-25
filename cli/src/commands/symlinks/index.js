const { basename, dirname, resolve } = require('path')
const { flags } = require('@oclif/command')
const { promisify } = require('util')
const dedent = require('dedent')
const fs = require('fs')

const readlink = promisify(fs.readlink)
const symlink = promisify(fs.symlink)
const rename = promisify(fs.rename)
const unlink = promisify(fs.unlink)
const mkdir = promisify(fs.mkdir)
const lstat = promisify(fs.lstat)

const BaseCommand = require('../../lib/base')
const symlinks = require('../../config/symlinks')
const {
  repoDir,
  homeDir,
} = require('../../config')

class SymlinkCommand extends BaseCommand {
  static flags = {
    force: flags.boolean({
      char: 'f',
      description: 'force symlink creation',
    }),
  }

  static args = []

  static description = dedent`
    Create symlinks between files in the home directory, and the symlinks kept
    in the dotfiles repository. These relationships can be found in the
    config/symlinks.json file.
  `

  static examples = [
    '$ dotfiles symlinks',
    '$ dotfiles symlinks --force',
  ]

  async run() {
    this.log('symlink command...')

    // TODO: something great
    // - load list of symlinked items
    // - check to see if their link exists
    // - if it doesn't exist; create it
    // Cases
    // - file doesn't exist (ENOENT)
    //  - symlink it
    // - file already exists (stats.isSymbolicLink() === false)
    //  - make a backup (fs.rename)
    //  - symlink it
    // - file already symlink (stats.isSymbolicLink() === true)
    //  - validate the link location
    //    - link location is incorrect; remove link
    //    - link location is correct; do nothing

    const promiseLinks = []
    for (const [ source, target ] of Object.entries(symlinks)) {
      const filepath = resolve(repoDir, source)
      const linkpath = resolve(homeDir, target)
      promiseLinks.push(this.manageFile(filepath, linkpath))
    }
    await Promise.all(promiseLinks)
  }

  /***
   * Determine if the target at `linkpath` is the same as the resolved filepath
   * within the dotfiles repository.
   *
   * @param {string} filepath filepath (source) of a symlink
   * @param {string} linkpath linkpath (target) of a symlink
   * @returns {boolean} Boolean value of equality of path locations
   */
  async isValidLinkpath(filepath, linkpath) {
    const rp = await readlink(linkpath)
    return (rp === resolve(repoDir, filepath))
  }

  /***
   * Determine if the target of `linkpath` is a file or not.
   *
   * @param {string} linkpath linkpath (target) of a symlink
   * @returns {(null|fs.Stats)} Result from lstat or null.
   */
  async doesFileExist(linkpath) {
    try {
      const stat = await lstat(linkpath)
      return stat
    } catch (error) {
      if (error.code === 'ENOENT') {
        // File doesn't exist
        return null
      }
      this.error(error)
    }
  }

  /***
   * Rename given file in order to create a backup. Results in `filename`.bak.
   *
   * @param {string} filepath path to the file to be renamed
   */
  async rename(filepath) {
    try {
      await rename(filepath, `${filepath}.bak`)
    } catch (error) {
      // Probably an access error
      this.error(error)
    }
  }

  /***
   * Symlink the source `filepath` to the target `linkpath`.
   *
   * @param {string} filepath source for symlink
   * @param {string} linkpath target for symlink
   * @param {Object} [opts] options object
   * @param {boolean} [opts.force] force symlink creation
   */
  async symlink(filepath, linkpath, opts = {}) {
    if (opts.force) {
      await unlink(linkpath)
    }
    if (dirname(linkpath) !== homeDir) {
      // Need to make directories
      await mkdir(dirname(linkpath), { recursive: true })
    }
    await symlink(filepath, linkpath)
  }

  async manageFile(filepath, linkpath) {
    const filename = basename(filepath)
    this.log(`linking ${filename} to ${linkpath} ...`)

    const stat = await this.doesFileExist(linkpath)
    if (stat) {
      // File exists
      if (stat.isSymbolicLink()) {
        // Validate symbolic link
        const isValid = await this.isValidLinkpath(filepath, linkpath)
        if (!isValid) {
          await this.symlink(filepath, linkpath, { force: true })
        }
        // Symbolic link path is correct; do nothing
      } else {
        // Not symbolic link; rename, and link
        await this.rename(linkpath) // backup file
        await this.symlink(filepath, linkpath)
      }
    } else {
      // linkpath doesn't exist; symlink it
      await this.symlink(filepath, linkpath)
    }
  }
}

module.exports = SymlinkCommand
