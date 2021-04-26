#!/usr/bin/env bash

if [ -f ~/.zshrc ] ; then
      echo "File is exist"
      mv -v ~/.zshrc ~/.zshrc.old
      ln -s -v /home/scudzy/dotfiles/.zshrc /home/scudzy/.zshrc
      echo "Symlink .zshrc done"
   else
      echo "File is not exist"
      ln -s -v /home/scudzy/dotfiles/.zshrc /home/scudzy/.zshrc
      echo "Symlink .zshrc done"
fi
if [ -f ~/.bashrc ] ; then
      echo "File is exist"
      mv -v ~/.bashrc ~/.bashrc.old
      ln -s -v /home/scudzy/dotfiles/.bashrc /home/scudzy/.bashrc
      echo "Symlink .bashrc done"
   else
      echo "File is not exist"
      ln -s -v /home/scudzy/dotfiles/bashrc /home/scudzy/.bashrc
      echo "Symlink .bashrc done"
fi
if [ -f ~/.profile ] ; then
      echo "File is exist"
      mv -v ~/.profile ~/.profile.old
      ln -s -v /home/scudzy/dotfiles/.profile /home/scudzy/.profile
      echo "Symlink .profile done"
   else
      echo "File is not exist"
      ln -s -v /home/scudzy/dotfiles/.profile /home/scudzy/.profile
      echo "Symlink .profile done"
fi
if [ -f ~/.vimrc ] ; then
      echo "File is exist"
      mv -v ~/.vimrc ~/.vimrc.old
      ln -s -v /home/scudzy/dotfiles/.vimrc /home/scudzy/.vimrc
      echo "Symlink .vimrc done"
   else
      echo "File is not exist"
      ln -s -v /home/scudzy/dotfiles/.vimrc /home/scudzy/.vimrc
      echo "Symlink .vimrc done"
fi
if [ -f /etc/resolv.conf ] ; then
      echo "File is exist"
      sudo mv -v /etc/resolv.conf /etc/resolv.conf.old
      sudo ln -s -v /home/scudzy/dotfiles/etc/resolv.conf /etc/resolv.conf
      echo "Symlink resolv.conf done"
   else
      echo "File is not exist"
      sudo ln -s -v /home/scudzy/dotfiles/etc/resolv.conf /etc/resolv.conf
      echo "Symlink resolv.conf done"
fi
if [ -f ~/.pyvoc/pyvoc.config ] ; then
      echo "File is exist"
      mv -v ~/.pyvoc/pyvoc.config ~/.pyvoc/pyvoc.config.old
      ln -s -v /home/scudzy/dotfiles/.pyvoc/pyvoc.config /home/scudzy/.pyvoc/pyvoc.config
      echo "Symlink pyvoc.config done"
   else
      echo "File is not exist"
      ln -s -v /home/scudzy/dotfiles/.pyvoc/pyvoc.config /home/scudzy/.pyvoc/pyvoc.config
      echo "Symlink pyvoc.config done"
fi
mkdir -p -v /home/scudzy/.local/share/fonts
sudo ln -s -v /home/scudzy/dotfiles/etc/wsl.conf /etc/wsl.conf
ln -s -v /home/scudzy/dotfiles/.gemrc /home/scudzy/.gemrc
ln -s -v /home/scudzy/dotfiles/.gitconfig /home/scudzy/.gitconfig
ln -s -v /home/scudzy/dotfiles/.tmux.conf /home/scudzy/.tmux.conf
ln -s -v /home/scudzy/dotfiles/.gitconfig.user /home/scudzy/.gitconfig.user
cp -r /home/scudzy/dotfiles/.local/ /home/scudzy/
cp -r /home/scudzy/dotfiles/.config/ /home/scudzy/
cp -r /home/scudzy/dotfiles/.vim/ /home/scudzy/
fc-cache -fv
