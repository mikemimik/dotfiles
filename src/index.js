'use strict'

const Cli = require('@mikemimik/cli')
const pkg = require('./package.json')

const initCommand = require('./commands/init')

const config = {
  cliName: 'dotcli'
}

const cli = new Cli(config)

module.exports = main

function main (argv) {
  const context = {
    cliVersion: pkg.version
  }

  return cli()
    .command(initCommand)
    .command({
      command: 'junk [value]',
      describe: 'a junk command',
      builder: (yargs) => yargs,
      handler: (argv) => {
        console.log('argv:', argv)
      }
    })
    .parse(argv, context)
}
