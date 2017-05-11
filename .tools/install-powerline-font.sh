#!/bin/sh

font_dir="$HOME/.fonts"
fontconfig_dir="$HOME/.config/fontconfig/conf.d"

mkdir -p "$font_dir"
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf -P "$font_dir"
fc-cache -vf "$font_dir"

mkdir -p "$fontconfig_dir"
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf -P "$fontconfig_dir"

