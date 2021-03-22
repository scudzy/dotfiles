#!/usr/bin/env bash
mv ~/.bashrc ~/.bashrc.old
mv ~/.profile ~/.profile.old
mkdir -p ~/.local/share/fonts
ln -s ~/dotfiles/.aliases ~/.aliases
ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.gemrc ~/.gemrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.profile ~/.profile
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.zshrc ~/.zshrc
sudo ln -s ~/dotfiles/etc/wsl.conf /etc/wsl.conf
cp -i ~/dotfiles/.gitconfig.user ~/.gitconfig.user
cp -r ~/dotfiles/.local/share/fonts/Meslo\ LG\ S\ Regular\ Nerd\ Font\ Complete.ttf ~/.local/share/fonts/
fc-cache -Ev