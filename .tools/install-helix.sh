#!/bin/sh

# if [ "$(id -u)" -ne 0 ]; then
# 	echo "requested operation requires superuser privilege"
# 	echo "enter root password"
# 	exec su - -c "$0 $*"
# fi

release_version=$(curl -fsSI 'https://github.com/helix-editor/helix/releases/latest' | grep -i 'location:' | grep -oP '(?<=/)[\d.]+')
dir_name="Helix"
archive_name="helix-$release_version-x86_64-linux.tar.xz"
download_url="https://github.com/helix-editor/helix/releases/download/$release_version/$archive_name"
tmp_dir="/tmp"
dest_dir=$HOME/Applications

echo "Helix $release_version will be downloaded now …"
curl -OL --output-dir "$tmp_dir" "$download_url"

if [ ! -d "$dest_dir/$dir_name" ]; then
	mkdir -p "$dest_dir/$dir_name"
fi
tar -xf "$tmp_dir/$archive_name" -C "$dest_dir/$dir_name" --strip-components=1

if [ -d "$HOME/.local/bin" ]; then
	ln -snf "$dest_dir/$dir_name/hx" "$HOME/.local/bin/hx"
fi

rm -rf "$tmp_dir/$dir_name" "$tmp_dir/$archive_name"
