#!/bin/sh

release_version=$(curl -fsSI 'https://github.com/jesseduffield/lazygit/releases/latest' | grep -i 'location:' | grep -oP '(?<=/v)[\d.]+')
archive_name="lazygit_${release_version}_Linux_x86_64.tar.gz"
download_url="https://github.com/jesseduffield/lazygit/releases/download/v$release_version/$archive_name"
dest_dir=$HOME/.local/bin

if [ ! -d "$dest_dir" ]; then
	echo "Aborting, $dest_dir is not a directory!"
	exit
fi

echo "Lazygit $release_version will be downloaded now …"
curl -L "$download_url" | tar -xzf - -C "$dest_dir" lazygit
