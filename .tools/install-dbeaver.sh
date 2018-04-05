#!/bin/sh

deb_file="$HOME/Downloads/dbeaver-ce_latest_amd64.deb"

if [ "$(id -u)" -ne 0 ]; then
	echo "requested operation requires superuser privilege"
	echo "enter root password"
	exec su -c "$0 $*"
fi

echo "Downloading DBeaver ..."
wget https://dbeaver.jkiss.org/files/dbeaver-ce_latest_amd64.deb -O "$deb_file"
if [ $? -ne 0 ]; then
	echo "Download failed"
	exit 1
fi

dpkg -i "$deb_file"
if [ $? -eq 0 ]; then
	rm "$deb_file"
	echo "DONE"
fi
