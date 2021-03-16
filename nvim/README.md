# Neovim configuration

To use this configuration, link the following after
cloning this repository to `<repo>`, and running
`git submodule update --init --recursive`:

```
ln -s ~/.config/nvim <repo>/nvim/config
ln -s ~/.local/share/nvim/site <repo>/nvim/site
```

## Packages (plugins)

Add a new package as a git submodule in `packages`, with:

```
git submodule add --name <NAME> <URL> site/pack/bundle/opt/<NAME>
```

and then add a section in the `init.vim` file:

```
packadd! <NAME>
```
