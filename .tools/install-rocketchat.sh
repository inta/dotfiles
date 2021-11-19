#!/bin/sh

release_url="https://github.com/RocketChat/Rocket.Chat.Electron/releases/"
current_url=$(curl -I ${release_url}latest | grep -oP '(?<=^location: )[\w\d:/.]+')
current_version=$(echo "$current_url" | grep -oP '(?<=/tag/)[0-9.]+')
deb_name=rocketchat_${current_version}_amd64.deb
download_url=${release_url}download/${current_version}/${deb_name}
deb_file=/tmp/${deb_name}

if [ "$(id -u)" -ne 0 ]; then
	echo "requested operation requires superuser privilege"
	echo "enter root password"
	exec su -c "$(realpath "$0") $*" -
fi

echo "Downloading Rocket.Chat.Electron ..."
if ! wget "$download_url" -O "$deb_file"; then
	echo "Download failed"
	exit 1
fi

if dpkg -i "$deb_file"; then
	rm "$deb_file"
	echo "DONE"
fi
