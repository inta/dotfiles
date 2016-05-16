#!/bin/sh

msg() {
	str=$1
	for color_num in $(echo $str | grep -oP "(?<=%)\d+(?=%)"); do
		if command -v tput > /dev/null; then
			local color=$(tput setaf $color_num)
			local default=$(tput sgr0)
		fi
		str=$(echo $str | sed s/%$color_num%/$color/)
	done
	printf "$str$default\n"
}

if ! command -v curl > /dev/null || ! command -v zsh > /dev/null; then
	msg "%1%ERROR: This script requires curl and zsh to be installed"
	exit 1;
fi

dotfiles_path=$(cd "$(dirname "$0")"; pwd)

msg "%4%Creating symlinks:"
files=".zshrc .gtkrc-2.0"
for file in $files; do
	if [ ! -h "$HOME/$file" ]; then
		mv "$HOME/$file" "$HOME/$file.bak"
		if [ $? -eq 0 ]; then
			msg "creating backup of $file: $file.bak"
		fi
		ln -s "$dotfiles_path/$file" "$HOME/$file"
		if [ $? -eq 0 ]; then
			msg "%2%creating symlink for $file"
		fi
	else
		msg "%3%symlink for $file already in place"
	fi
done
