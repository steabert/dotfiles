# Configuration files

## Installation

To use the configuration files, first make sure you
download all necessary git submodules with:

```
git submodule update --init --recursive
```

and the run the included linking script:

```shell
./install.sh
```

which will link from the proper locations in your
home directory to the files in the repository.

## NeoVIM

### Packages (plugins)

Add a new package as a git submodule under `site`, with:

```shell
git submodule add --name <NAME> <URL> site/pack/bundle/opt/<NAME>
```

and then add a corresponding section in the `init.lua` file
in order to load the plugin:

```lua
vim.cmd('packadd! <NAME>')
```

### Configuration

Some language server support requires manual installation of
the appropriate language servers:

```shell
npm --global add graphql-language-service-cli
```
