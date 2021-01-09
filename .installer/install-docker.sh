#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
	echo "requested operation requires superuser privilege"
	echo "enter root password"
	exec su -c "$0 $*"
fi

# install docker
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/debian bullseye stable" > /etc/apt/sources.list.d/docker.list

apt update
apt install -y docker-ce

if [ -n "$1" ] && id "$1" >/dev/null 2>&1; then
	adduser $1 docker
fi
