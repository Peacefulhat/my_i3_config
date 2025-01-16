#!/bin/zsh

file=$1

check_aur_installation() {
    if command -v yay > /dev/null; then
        return 0  
    else
        return 1
    fi
}

install_pkg() {
    while IFS= read -r line || [[ -n "$line" ]]; do
        echo "Checking for package: $line"
        if pacman -Q "$line" > /dev/null 2>&1; then
            echo "$line is already installed."
        else
            echo "$line not installed, installing..."
            yay -S --noconfirm "$line"
        fi
    done < "$file"
}

if check_aur_installation; then
    echo "yay is already installed, parsing file..."
    install_pkg
else
    echo "yay is not installed. Please install yay first."
fi

