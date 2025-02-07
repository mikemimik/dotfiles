# TMUX Support

It's necessary to add the following function to the `nvm.sh` file in order for
the tmux status bar to function correctly in these dotfiles.

```bash
if [ -n $TMUX ]; then
  tmux setenv -g "TMUX_NVM_$(tmux display -p "#D" | tr -d %)" "$NVM_BIN"
fi
```

The function above needs to be added to the `nvm` function inside of the
`nvm.sh` file. There is a switch case for `"use")` and inside this case
statement there are updates to `PATH`, `NVM_BIN`, and `NVM_INC` environment
variables. This function can be added just after these [`export`
lines](https://github.com/nvm-sh/nvm/blob/d1a22a63bd38c0392393044354297e5ca02bc0cf/nvm.sh#L3642-L3645).
