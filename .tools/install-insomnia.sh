#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
	echo "requested operation requires superuser privilege"
	echo "enter root password"
	exec su -c "$0 $*"
fi

wget -O - https://insomnia.rest/keys/debian-public.key.asc | apt-key add -
if [ ! -f /etc/apt/sources.list.d/insomnia.list ]; then
	echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" | tee /etc/apt/sources.list.d/insomnia.list
fi

apt update && apt install insomnia

