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

# ensure a directory path exists
dir path:
    if [[ ! -d {{path}} ]]; then mkdir -p {{path}}; fi

# https://github.com/facebookincubator/fastmod
fastmod:
    cargo install fastmod

# https://github.com/sharkdp/fd
fd-find:
    cargo install fd-find

# https://go.dev/
go version='1.24.3': (dir "~/opt")
    if [[ ! -f ~/opt/go{{version}}.linux-amd64.tar.gz ]]; then \
        curl -L -O --output-dir ~/opt https://go.dev/dl/go{{version}}.linux-amd64.tar.gz; \
    fi
    cd ~/opt && if [[ -d go ]]; then rm -r go; fi && tar -xzf go{{version}}.linux-amd64.tar.gz
    go version

# https://github.com/nakst/gf
gf: (dir "~/opt") (dir "~/.local/bin")
    if [[ ! -d ~/opt/gf ]]; then \
      cd ~/opt && git clone https://github.com/nakst/gf; \
    fi
    cd ~/opt/gf && ./build.sh
    ln -sf ~/opt/gf/gf2 ~/.local/bin/

# https://helix-editor.com/
helix version='25.01.1': (dir "~/opt") (dir "~/.local/bin") (dir "~/.config")
    if [[ ! -f ~/opt/helix-{{version}}-x86_64-linux.tar.xz ]]; then \
        curl -L -O --output-dir ~/opt \
          https://github.com/helix-editor/helix/releases/download/{{version}}/helix-{{version}}-x86_64-linux.tar.xz; \
    fi
    cd ~/opt && tar -xJf helix-{{version}}-x86_64-linux.tar.xz
    ln -sf ~/opt/helix-{{version}}-x86_64-linux/hx ~/.local/bin
    ln -sf {{justfile_directory()}}/helix ~/.config/

# https://typeof.net/Iosevka/
iosevka version='33.2.3': (dir "~/.local/share/fonts/iosevka")
    if [[ ! -f ~/opt/SuperTTC-SGr-IosevkaFixedSlab-{{version}}.zip ]]; then \
        curl -L -O --output-dir ~/opt \
          https://github.com/be5invis/Iosevka/releases/download/v{{version}}/SuperTTC-SGr-IosevkaFixedSlab-{{version}}.zip; \
        curl -L -O --output-dir ~/opt \
          https://github.com/be5invis/Iosevka/releases/download/v{{version}}/PkgTTF-IosevkaFixedSlab-{{version}}.zip; \
    fi
    unzip -o -f ~/opt/SuperTTC-SGr-IosevkaFixedSlab-{{version}}.zip -d ~/.local/share/fonts/iosevka 
    unzip -o -f ~/opt/PkgTTF-IosevkaFixedSlab-{{version}}.zip -d ~/.local/share/fonts/iosevka 
    fc-cache

# https://sw.kovidgoyal.net/kitty/
kitty: (dir "~/.config") (dir "~/.local/bin") (dir "~/.local/share/applications")
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
    ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
    sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop
    sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty.desktop
    echo 'kitty.desktop' > ~/.config/xdg-terminals.list
    ln -sf {{justfile_directory()}}/kitty ~/.config/

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
nushell version='0.104.0':
    if [[ ! -f ~/opt/nu-{{version}}-x86_64-unknown-linux-musl.tar.gz ]]; then \
        curl -L -O --output-dir ~/opt \
          https://github.com/nushell/nushell/releases/download/{{version}}/nu-{{version}}-x86_64-unknown-linux-musl.tar.gz; \
    fi
    cd ~/opt && tar -xzf nu-{{version}}-x86_64-unknown-linux-musl.tar.gz
    ln -sf ~/opt/nu-{{version}}-x86_64-unknown-linux-musl/nu ~/.local/bin
    mkdir ~/.config/nushell && ln -sf {{justfile_directory()}}/config.nu ~/.config/nushell/config.nu

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
