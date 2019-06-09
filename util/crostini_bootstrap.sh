#!/bin/bash

sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install -y \
	git \
	g++ \
	libgtk-3-dev \
	gtk-doc-tools \
	gnutls-bin \
	valac \
	intltool \
	libpcre2-dev \
	libglib3.0-cil-dev \
	libgnutls28-dev \
	libgirepository1.0-dev \
	libxml2-utils \
	gperf \
    zsh \
    python3-pip \
    python-pip \
    htop \
    mosh \
    autossh \
    mosh \
    tmux


export LIBRARY_PATH="/usr/include/gtk-3.0:$LIBRARY_PATH"

git clone https://github.com/thestinger/vte-ng.git
cd vte-ng && ./autogen.sh && make && sudo make install

git clone --recursive https://github.com/thestinger/termite.git
cd ../termite && make && sudo make install
sudo ldconfig
sudo mkdir -p /lib/terminfo/x; sudo ln -s \
/usr/local/share/terminfo/x/xterm-termite \
/lib/terminfo/x/xterm-termite

git clone https://github.com/neovim/neovim.git
cd ../neovim && git checkout release-0.3
make CMAKE_BUILD_TYPE=Release && sudo make install
sudo pip3 install pynvim

cd .. && git clone https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install
