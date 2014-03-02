# Command line fu

## Set date on another computer over ssh

When setting a date, you can read stdin as argument
to the `--set` option, just make sure to pass `-0`
to `xargs` to use null as delimiter for the argument.

```
date -u | ssh user@hostname "xargs -0 sudo date -s"
```
