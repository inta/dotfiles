#!/bin/sh

release_version=$(curl -fsSI 'https://github.com/bcicen/ctop/releases/latest' | grep -i 'location:' | grep -oP '(?<=/v)[\d.]+')
binary_name="ctop-${release_version}-linux-amd64"
download_url="https://github.com/bcicen/ctop/releases/download/v$release_version/$binary_name"
dest_dir=$HOME/.local/bin

if [ ! -d "$dest_dir" ]; then
	echo "Aborting, $dest_dir is not a directory!"
	exit
fi

if command -v ctop >/dev/null && [ "$(ctop -v | grep -oP '(?<=ctop version )\d[\d.]*')" = "$release_version" ]; then
	echo "Already up to date..."
	exit
fi

echo "Ctop $release_version will be downloaded now …"
curl -L -o "$dest_dir/ctop" "$download_url"
chmod +x "$dest_dir/ctop"
