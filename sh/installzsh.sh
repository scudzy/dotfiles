#!/bin/bash

# Check for Zsh installation
if ! command -v zsh > /dev/null; then
    echo "Zsh is not installed. Installing now..."
    sudo apt install zsh
else
    echo "Zsh is already installed."
fi

# Clone the GitHub repo
echo "Cloning the GitHub repo..."
git clone https://github.com/<username>/<repo>.git <repo_name>

# Mass copy files all over system-wide
echo "Mass copying files all over system-wide..."
sudo cp -r <repo_name>/* /

# Change the default shell to Zsh
echo "Changing the default shell to Zsh..."
chsh -s /bin/zsh

echo "Done!"
