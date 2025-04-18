#!/bin/zsh
file=$1

./install_pkg.sh $file

echo "Installing yay..."
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
echo "removing yay folder..."
rm -rf yay

echo "copying files data ..."
mkdir ~/.emacs.d
./copy.sh
./ohmyzsh.sh
