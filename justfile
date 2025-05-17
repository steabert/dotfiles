# Run ./bootstrap.sh first to install prerequisites for running just

set shell := ["bash", "-uec"]

default:
    just --list

# https://github.com/go-delve/delve
delve:
    go install github.com/go-delve/delve/cmd/dlv@latest
    go install github.com/aarzilli/gdlv@latest
    
dev:
    sudo apt update
    sudo apt install binutils clang clangd fasm gdb gcc g++ nasm valgrind
    
# https://github.com/facebookincubator/fastmod
fastmod:
    cargo install fastmod

# https://github.com/sharkdp/fd
fd-find:
    cargo install fd-find

# https://go.dev/
go version='1.24.3':
    if [[ ! -f ~/opt/go{{version}}.linux-amd64.tar.gz ]]; then \
        curl -L -O --output-dir ~/opt https://go.dev/dl/go{{version}}.linux-amd64.tar.gz; \
    fi
    cd ~/opt && if [[ -d go ]]; then rm -r go; fi && tar -xzf go{{version}}.linux-amd64.tar.gz
    go version

# https://github.com/nakst/gf
gf:
    if [[ ! -d ~/opt/gf ]]; then \
      cd ~/opt && git clone https://github.com/nakst/gf; \
    fi
    cd ~/opt/gf && ./build.sh

# https://helix-editor.com/
helix version='25.01.1':
    if [[ ! -f ~/opt/helix-{{version}}-x86_64-linux.tar.xz ]]; then \
        curl -L -O --output-dir ~/opt \
          https://github.com/helix-editor/helix/releases/download/{{version}}/helix-{{version}}-x86_64-linux.tar.xz; \
    fi
    cd ~/opt && tar -xJf helix-{{version}}-x86_64-linux.tar.xz
    ln -sf ~/opt/helix-{{version}}-x86_64-linux/hx ~/.local/bin

# https://typeof.net/Iosevka/
iosevka version='33.2.2':
    if [[ ! -f ~/opt/SuperTTC-SGr-IosevkaFixedSlab-{{version}}.zip ]]; then \
        curl -L -O --output-dir ~/opt \
          https://github.com/be5invis/Iosevka/releases/download/v{{version}}/SuperTTC-SGr-IosevkaFixedSlab-{{version}}.zip; \
    fi
    mkdir -p ~/.local/share/fonts/iosevka
    unzip ~/opt/SuperTTC-SGr-IosevkaFixedSlab-{{version}}.zip -d ~/.local/share/fonts/iosevka 
    fc-cache

# https://sw.kovidgoyal.net/kitty/
kitty:
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Language Servers
lsp:
    rustup component add rust-analyzer
    go install golang.org/x/tools/gopls@latest
    
# https://nodejs.org/en
node version='22.15.1':
    if [[ ! -f ~/opt/node-v{{version}}-linux-x64.tar.xz ]]; then \
        curl -L -O --output-dir ~/opt \
          https://nodejs.org/dist/v{{version}}/node-v{{version}}-linux-x64.tar.xz; \
    fi
    cd ~/opt && tar -xJf node-v{{version}}-linux-x64.tar.xz && ln -sf node-v{{version}}-linux-x64 node

# https://www.nushell.sh/
nu version='0.104.0':
    if [[ ! -f ~/opt/nu-{{version}}-x86_64-unknown-linux-musl.tar.gz ]]; then \
        curl -L -O --output-dir ~/opt \
          https://github.com/nushell/nushell/releases/download/{{version}}/nu-{{version}}-x86_64-unknown-linux-musl.tar.gz; \
    fi
    cd ~/opt && tar -xzf nu-{{version}}-x86_64-unknown-linux-musl.tar.gz
    ln -sf ~/opt/nu-{{version}}-x86_64-unknown-linux-musl/nu ~/.local/bin

# https://www.rust-lang.org/
rustup:
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# https://ultimatehackingkeyboard.com/agent
uhk version='7.0.0':
    if [[ ! -f ~/opt/UHK.Agent-{{version}}-linux-x86_64.AppImage ]]; then \
        curl -L -O --output-dir ~/opt \
          https://github.com/UltimateHackingKeyboard/agent/releases/download/v{{version}}/UHK.Agent-{{version}}-linux-x86_64.AppImage; \
    fi
    chmod +x ~/opt/UHK.Agent-{{version}}-linux-x86_64.AppImage
    ln -sf ~/opt/UHK.Agent-7.0.0-linux-x86_64.AppImage ~/.local/bin/uhk-agent

# https://zen-browser.app/
zen:
    if [[ ! -f ~/opt/zen.linux-x86_64.tar.xz ]]; then \
        curl -L -O --output-dir ~/opt \
          https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.xz; \
    fi
    cd ~/opt && tar -xJf zen.linux-x86_64.tar.xz
    ln -sf ~/opt/zen/zen ~/.local/bin
    cp zen.desktop ~/.local/share/applications/
