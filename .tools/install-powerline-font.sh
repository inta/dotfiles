#!/bin/sh

font_dir="$HOME/.fonts"
fontconfig_dir="$HOME/.config/fontconfig/conf.d"

mkdir -p "$font_dir"
mkdir -p "$fontconfig_dir"

wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf -P "$font_dir"
wget https://github.com/gabrielelana/awesome-terminal-fonts/raw/master/build/fontawesome-regular.ttf -P "$font_dir"
fc-cache -vf "$font_dir"

wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf -P "$fontconfig_dir"
wget https://github.com/gabrielelana/awesome-terminal-fonts/raw/master/config/10-symbols.conf -P "$fontconfig_dir"

