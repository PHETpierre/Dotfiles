#!/bin/bash

#home
ln -sf /home/pierre/.dotfiles/.bashrc /home/pierre/.bashrc
ln -sf /home/pierre/.dotfiles/.alacritty.yml /home/pierre/.alacritty.yml
ln -sf /home/pierre/.dotfiles/i3/config /home/pierre/.config/i3/config
ln -sf /home/pierre/.dotfiles/.zshrc /home/pierre/.zshrc

ln -sf /home/pierre/.dotfiles/nvim/init.vim /home/pierre/.config/nvim/init.vim
ln -sf /home/pierre/.dotfiles/nvim/lua/plugins.lua /home/pierre/.config/nvim/lua/plugins.lua

#etc
ln -sf /home/pierre/.dotfiles/rc.conf /etc/ranger/config/rc.conf 

# $SHELL
