#!/bin/sh

# Copy or link relevant configuration files from the local GitHub repo to their
# respective home.

# Git
ln -sfT $PWD/gitconfig ~/.gitconfig

# Editor config
#ln -sfT $PWD/editorconfig.ini ~/.editorconfig

# NeoVIM
#ln -sfT $PWD/nvim/config ~/.config/nvim
#ln -sfT $PWD/nvim/site ~/.local/share/nvim/site

# Terminal
ln -sfT $PWD/alacritty ~/.config/alacritty
ln -sfT $PWD/kitty ~/.config/kitty
ln -sfT $PWD/base16-shell ~/.config/base16-shell

# Shell
ln -sfT $PWD/zshenv ~/.zshenv
ln -sfT $PWD/zshrc ~/.zshrc
ln -sfT $PWD/zprofile ~/.zprofile

# Tmux
ln -sfT $PWD/tmux.conf ~/.tmux.conf

# Sway
ln -sfT $PWD/waybar ~/.config/waybar
ln -sfT $PWD/sway ~/.config/sway

# Finder
ln -sfT $PWD/fdignore ~/.fdignore

# Knowledge base
ln -sfTn $PWD/kb ~/kb

# Scripts
for file in $PWD/bin/*; do
	ln -sfT $file ~/bin/$(basename $file)
done
