const { Command } = require('@oclif/command')
const dedent = require('dedent')

class BaseCommand extends Command {
  static aliases = []

  static strict = true

  static flags = {}

  static args = []

  static description = dedent`
  `

  static examples = []

  async init() {
    const { flags, args, argv } = this.parse(this.constructor)
    this.flags = flags
    this.args = args
    this.argv = argv
    /* eslint-disable-next-line no-console */
    this.logError = console.error
    try {
      await this._init()
    } catch (error) {
      this.error(error)
    }
  }

  // INFO: to be instanciated by inherited classes
  async _init() {}

  async catch(error) {
    this.error(error)
  }
}

module.exports = BaseCommand
