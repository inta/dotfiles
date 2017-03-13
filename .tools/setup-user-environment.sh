#!/bin/sh

if [ ! -L ~/.config ]; then
	cp -a ~/.config/* ~/.dotfiles/.config/
	rm -rf ~/.config/
	ln -s ~/.dotfiles/.config ~/.config
fi

if [ ! -L ~/.zshrc ]; then
	mv ~/.zshrc ~/.zshrc.backup
	ln -s ~/.dotfiles/.zshrc ~/.zshrc
fi

chsh -s /bin/zsh

