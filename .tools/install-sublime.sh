#!/bin/sh

deb_url=$(wget -qO - https://www.sublimetext.com/3 | grep -Po '(?<=href=")[^"]*(?=">\s*Ubuntu 64 bit)')
deb_file=$(basename "$deb_url")
deb_log="$(dirname $0)/.installed-sublime.log"

if [ -f "$deb_log" ]; then
	deb_old=$(cat "$deb_log")
	if [ "$deb_file" = "$deb_old" ]; then
		echo "No new version available – stopping install script"
		exit
	fi
	dpkg -r "$deb_old"
fi

wget "$deb_url"
dpkg -i "$deb_file"
echo "$deb_file" > "$deb_log"
rm "$deb_file"

