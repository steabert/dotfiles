# To bootstrap software installation, install just into a directory in PATH:
#   curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to $HOME/.local/bin

set shell := ["bash", "-uec"]

default:
    just --list

nushell version='0.104.0':
    if [[ ! -f ~/opt/nu-{{version}}-x86_64-unknown-linux-musl.tar.gz ]]; then \
      curl -L -O --output-dir ~/opt \
        https://github.com/nushell/nushell/releases/download/{{version}}/nu-{{version}}-x86_64-unknown-linux-musl.tar.gz; \
    fi
    cd opt && tar -xzf nu-{{version}}-x86_64-unknown-linux-musl.tar.gz
    ln -sf ~/opt/nu-{{version}}-x86_64-unknown-linux-musl/nu ~/.local/bin

helix version='25.01.1':
    if [[ ! -f ~/opt/helix-{{version}}-x86_64-linux.tar.xz ]]; then \
      curl -L -O --output-dir ~/opt \
        https://github.com/helix-editor/helix/releases/download/{{version}}/helix-{{version}}-x86_64-linux.tar.xz; \
    fi
    cd opt && tar -xJf helix-{{version}}-x86_64-linux.tar.xz
    ln -sf ~/opt/helix-{{version}}-x86_64-linux/hx ~/.local/bin

rustup:
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
