#!/bin/sh

set -e

echo "Cloning git repositories into place:"
git clone git://github.com/haplesshero13/lc3tools.git
git clone git://github.com/haplesshero13/lcc-lc3.git

echo
echo "Now configuring, compiling, and installing lc3tools..."
cd lc3tools
./configure
make install
make clean
make clear

echo
echo "Now configuring, compiling, and installing lcc-lc3..."
cd ../lcc-lc3
./configure
make install
make clean
make clear
echo "Binaries compiled and installed."

echo "Removing downloaded source files..."
cd ..
rm -rf lc3tools
rm -rf lcc-lc3

echo "Adding LC3 Platform binaries to PATH environment variable..."
LC3_PATH="$HOME/\.lc3"
if [[ "$PATH" =~ $LC3_PATH ]]; then
  echo "Path already contains \"$HOME/.lc3\"."
else
  if [[ "$SHELL" =~ .*zsh ]]; then
    echo "# LC3 Tools" >> ~/.zshrc
    echo 'export PATH="$HOME/.lc3:$PATH"' >> ~/.zshrc
    echo "Added $HOME/.lc3 to your PATH in your zshrc."
  fi

  if [[ "$SHELL" =~ .*bash ]]; then
    echo "# LC3 Tools" >> ~/.bash_profile
    echo 'export PATH="$HOME/.lc3:$PATH"' >> ~/.bash_profile
    echo "Added $HOME/.lc3 to your PATH in your bash_profile."
  fi
  echo "(You may have to restart your shell session for this change to take effect.)"
fi

echo "Finished installing the LC3 Developer Platform!"
