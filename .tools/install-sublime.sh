#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
	echo "requested operation requires superuser privilege"
	echo "enter root password"
	exec su - -c "$0 $*"
fi

curl https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | tee /usr/share/keyrings/sublimehq-pub.gpg
echo "deb [signed-by=/usr/share/keyrings/sublimehq-pub.gpg] https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list

apt update && apt install sublime-text
