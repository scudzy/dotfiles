#!/usr/bin/env bash
mv /home/scudzy/.bashrc /home/scudzy/.bashrc.old
mv /home/scudzy/.profile /home/scudzy/.profile.old
mkdir -p /home/scudzy/.local/share/fonts
ln -s /home/scudzy/dotfiles/.aliases /home/scudzy/.aliases
ln -s /home/scudzy/dotfiles/.bashrc /home/scudzy/.bashrc
ln -s /home/scudzy/dotfiles/.gemrc /home/scudzy/.gemrc
ln -s /home/scudzy/dotfiles/.gitconfig /home/scudzy/.gitconfig
ln -s /home/scudzy/dotfiles/.profile /home/scudzy/.profile
ln -s /home/scudzy/dotfiles/.tmux.conf /home/scudzy/.tmux.conf
ln -s /home/scudzy/dotfiles/.vimrc /home/scudzy/.vimrc
ln -s /home/scudzy/dotfiles/.zshrc /home/scudzy/.zshrc
sudo ln -s /home/scudzy/dotfiles/etc/wsl.conf /etc/wsl.conf
cp -i /home/scudzy/dotfiles/.gitconfig.user /home/scudzy/.gitconfig.user
cp -r /home/scudzy/dotfiles/.local/ /home/scudzy/
cp -r /home/scudzy/dotfiles/.config/ /home/scudzy/
cp -r /home/scudzy/dotfiles/.vim/ /home/scudzy/
cp -r /home/scudzy/dotfiles/.pyvoc/ /home/scudzy/
fc-cache -fv