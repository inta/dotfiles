#!/bin/sh

release_version=$(curl -fsSI 'https://github.com/lapce/lapce/releases/latest' | grep -i 'location:' | grep -oP '(?<=/v)[\d.]+')
dir_name="Lapce"
archive_name="$dir_name-linux.tar.gz"
download_url="https://github.com/lapce/lapce/releases/download/v$release_version/$archive_name"
tmp_dir="/tmp"
dest_dir=$HOME/Applications

echo "Lapce $release_version will be downloaded now …"
curl -OL --output-dir "$tmp_dir" "$download_url"
tar -xf "$tmp_dir/$archive_name" -C "$dest_dir"
rm "$tmp_dir/$archive_name"

if [ -d "$HOME/.local/bin" ]; then
	ln -snf "$dest_dir/$dir_name/lapce" "$HOME/.local/bin/lapce"
fi
