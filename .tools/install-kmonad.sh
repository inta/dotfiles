#!/bin/sh

release_version=$(curl -fsSI 'https://github.com/kmonad/kmonad/releases/latest' | grep -i 'location:' | grep -oP '(?<=/)[\d.]+')
file_name="kmonad"
download_url="https://github.com/kmonad/kmonad/releases/download/$release_version/$file_name"
dest_dir=$HOME/.local/bin

if [ ! -d "$dest_dir" ]; then
	echo "Aborting, $dest_dir is not a directory!"
	exit
fi

if command -v kmonad >/dev/null && [ "$(kmonad --version | grep -oP '^[\d.]+')" = "$release_version" ]; then
	echo "Already up to date..."
	exit
fi

echo "Kmonad $release_version will be downloaded now …"
curl -Lo "$dest_dir/$file_name" "$download_url"
chmod +x "$dest_dir/$file_name"
