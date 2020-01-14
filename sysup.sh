#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
	echo "requested operation requires superuser privilege"
	echo "enter root password"
	exec su -c "$0 $*"
fi

apt install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	htop \
	net-tools \
	psmisc \
	zsh \
	neovim \
	rsync \
	encfs \
	shellcheck \
	tilda \
	remmina \
	fish \
	adwaita-qt

# install docker
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/debian buster stable" > /etc/apt/sources.list.d/docker.list

apt update
apt install -y docker-ce

#adduser foo docker

# install vscode
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

apt update
apt install -y code

# install node
curl -sL https://deb.nodesource.com/setup_11.x | bash -

apt update
apt install -y nodejs
