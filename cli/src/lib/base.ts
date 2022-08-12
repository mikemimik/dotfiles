import { Command } from "@oclif/core";

export default abstract class BaseCommand extends Command {
  async init() {
    // @ts-ignore
    const { flags, args, argv } = await this.parse(this.constructor);

    // @ts-ignore
    this.flags = flags;
    // @ts-ignore
    this.args = args;
    // @ts-ignore
    this.argv = argv;

    try {
      await this._init();
    } catch (err) {
      this.error(<Error>err);
    }
  }

  async _init(): Promise<void> {}
}
