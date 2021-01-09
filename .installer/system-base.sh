#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
	echo "requested operation requires superuser privilege"
	echo "enter root password"
	exec su -c "$0 $*"
fi

apt install -y \
	htop \
	net-tools \
	zsh \
	neovim \
	rsync \
	encfs \
	shellcheck \
	remmina \
	fish \
	network-manager-openvpn-gnome

