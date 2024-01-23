#!/bin/sh

release_url=https://github.com/KRTirtho/spotube/releases/
release_version=$(curl -sL "https://api.github.com/repos/KRTirtho/spotube/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
deb_name=Spotube-linux-x86_64.deb
download_url=${release_url}download/v${release_version}/${deb_name}
deb_file=/tmp/${deb_name}
current_version=unknown

if command -v spotube >/dev/null; then
	current_version=$(spotube --version 2>/dev/null | grep -oP '\d[\d.]+\d')
fi

if [ "$current_version" = "$release_version" ]; then
	echo "You are up to date (version $current_version)"
	exit
fi

if [ "$(id -u)" -ne 0 ]; then
      echo "requested operation requires superuser privilege"
      echo "enter root password"
      exec su - -c "$0 $*"
fi

echo "Downloading spotube ..."
if ! curl -fsSL "$download_url" -o "$deb_file"; then
	echo "Download failed"
	exit 1
fi

echo "Installing spotube ${release_version} ..."
if dpkg -i "$deb_file"; then
	rm "$deb_file"
	echo "DONE"
fi
