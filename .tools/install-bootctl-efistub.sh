#!/bin/sh

# see https://www.glasen-hardt.de/2016/10/03/bootctl-als-alternative-zu-grub2/

download_url="https://www.glasen-hardt.de/wp-content/uploads/2016/09/bootctl_0.1-ubuntu1_amd64.deb"
deb_file="$HOME/Downloads/bootctl_0.1-ubuntu1_amd64.deb"

if [ "$(id -u)" -ne 0 ]; then
	echo "requested operation requires superuser privilege"
	echo "enter root password"
	exec su -c "$0 $*"
fi

wget "$download_url" -O "$deb_file"
if [ $? -ne 0 ]; then
	echo "Download failed"
	exit 1
fi

dpkg -i "$deb_file"
if [ $? -eq 0 ]; then
	rm "$deb_file"
	echo "DONE"
fi
