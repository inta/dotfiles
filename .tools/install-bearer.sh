#!/bin/sh

release_url=https://github.com/Bearer/bearer/releases/
release_version=$(curl -sL "https://api.github.com/repos/Bearer/bearer/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
deb_name=bearer_${release_version}_linux-amd64.deb
download_url=${release_url}download/v${release_version}/${deb_name}
deb_file=/tmp/${deb_name}
current_version=unknown

if command -v bearer >/dev/null; then
	current_version=$(bearer version 2>&1 | head -n 1 | grep -oP '\d[\d.]+\d')
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

echo "Downloading bearer ..."
if ! curl -fsSL "$download_url" -o "$deb_file"; then
	echo "Download failed"
	exit 1
fi

echo "Installing bearer ${release_version} ..."
if dpkg -i "$deb_file"; then
	rm "$deb_file"
	echo "DONE"
fi
