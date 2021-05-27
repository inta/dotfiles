#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
	echo "requested operation requires superuser privilege"
	echo "enter root password"
	exec su -c "$0 $*"
fi

apt install -y \
	pm-utils \
	zsh \
	fish \
	shellcheck \
	net-tools \
	network-manager-openvpn-gnome \
	htop \
	rsync \
	encfs \
	neovim \
	remmina \
	build-essential
