#!/bin/sh

extension_name="svgo-inkscape"
extension_path="$HOME/.config/inkscape/extensions"
extension_git="https://github.com/juanfran/svgo-inkscape.git"

if [ ! -d "$extension_path/$extension_name" ]; then
	git clone $extension_git "$extension_path/$extension_name"
else
	cd "$extension_path/$extension_name" || exit
	git pull
fi

cd "$extension_path/$extension_name/$extension_name" || exit
npm i
