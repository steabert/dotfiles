sudo apt update
sudo apt install \
	binutils \
	curl \
	git \
	vim

mkdir -p ~/opt
mkdir -p ~/.local/bin

curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to $HOME/.local/bin
