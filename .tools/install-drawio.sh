#!/bin/bash

release_url="https://github.com/jgraph/drawio-desktop/releases/"
current_url=$(curl -I ${release_url}latest | grep location: | cut -s -d' ' -f2)
current_version=$(basename "$current_url" | sed 's/^v//' | tr -dc '[:print:]')
deb_name="drawio-amd64-${current_version}.deb"
download_url=${release_url}download/v${current_version}/${deb_name}
deb_file=/tmp/${deb_name}

if [ "$(id -u)" -ne 0 ]; then
	echo "requested operation requires superuser privilege"
	echo "enter root password"
	exec su -c "$(realpath "$0") $*" -
fi

echo "Downloading Draw.io Desktop application ..."
if ! wget "$download_url" -O "$deb_file"; then
	echo "Download failed"
	exit 1
fi

if dpkg -i "$deb_file"; then
	rm "$deb_file"
	echo "DONE"
fi
