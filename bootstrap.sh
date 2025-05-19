#!/usr/bin/env bash

# install just locally
sudo apt update && sudo apt install curl
mkdir bin
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to bin/

# install default shell & terminal, after which
# it should be possible to find kitty in the desktop apps
# and it should open with nushell
bin/just nushell
bin/just kitty
