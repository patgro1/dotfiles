#!/usr/bin/env bash

# TODO: This could be placed in a particular script script?
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release > /dev/null 2>&1; then
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
fi

if [ $OS = "Ubuntu" ]; then
    PACMAN="apt"
    PACMAN_INSTALL="apt install"
fi

if [ $OS = "Ubuntu" ]; then
    PACKAGE_LIST="ninja-build gettext cmake curl build-essential"
fi

sudo $PACMAN_INSTALL -y $PACKAGE_LIST

# Check if there is already a neovim installed in the directory
NVIM_SRC_DIR="$HOME/workspace/tools/neovim"
if [ ! -d $NVIM_SRC_DIR ]; then
    # Making sure the tools directory exists
    mkdir -p $(dirname $NVIM_SRC_DIR)
    git clone https://github.com/neovim/neovim $NVIM_SRC_DIR
fi

# For now, we always use the latest release but eventually we could take a parameter from the user to choose a point to use
NEOVIM_RELEASE_VERSION=$(curl -Ls https://github.com/neovim/neovim/releases/latest | grep -Po -m1 '"Release Nvim .*"' | awk '{print $3}')
echo "Latest neovim release: $NEOVIM_RELEASE_VERSION"
pushd $NVIM_SRC_DIR
CURRENT_NVIM_CHECKOUT=$(git describe --tags --always)
# TODO: if we want to use something else than a tag we will need to do it in a different way
if [ $CURRENT_NVIM_CHECKOUT = "v$NEOVIM_RELEASE_VERSION" ]; then
    echo "Neovim already up to date"
    popd
    exit
fi
git checkout -q "v$NEOVIM_RELEASE_VERSION"
make distclean
make deps
make CMAKE_BUILD_TYPE=Release
sudo make install
popd

