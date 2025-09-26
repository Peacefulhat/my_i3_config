#!/bin/zsh
#simple package installer
echo "Installing apps needed...."
file_path=$1

while read -r line; do
    if [[ ${line:0:1} == "#" ]]; then
        continue
    fi
    echo "Checking package: $line"
    if pacman -Q "$line" &> /dev/null; then
        echo "$line is already installed."
    else
        echo "$line is not installed. Installing..."
        sudo pacman -S --noconfirm "$line"
    fi
done < "$file_path"

