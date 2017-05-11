#!/bin/sh

mkdir -p ~/.fonts && cd $_
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
fc-cache -vf ~/.fonts/

mkdir -p ~/.config/fontconfig/conf.d && cd $_
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

