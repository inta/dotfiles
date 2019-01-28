#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
	echo "requested operation requires superuser privilege"
	echo "enter root password"
	exec su - -c "$0 $*"
fi

wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | apt-key add -
if [ ! -f /etc/apt/sources.list.d/dbeaver.list ]; then
	echo "deb https://dbeaver.io/debs/dbeaver-ce /" | tee /etc/apt/sources.list.d/dbeaver.list
fi

apt update && apt install dbeaver-ce

