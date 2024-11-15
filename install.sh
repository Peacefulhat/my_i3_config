#!/bin/zsh
file=$1
./install_pkg.sh $file
echo"Installing smex..."
git clone https://github.com/nonsequitur/smex.git
mkdir ~/.emacs.d
./copy.sh
./ohmyzsh.sh
