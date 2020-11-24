#!/bin/sh

# dir with the pictures
dir=$(dirname "$(gsettings get org.gnome.desktop.screensaver picture-uri | sed s/\'file:\\/\\///)")

# get random jpg from dir
# random_file=$(ls "$dir" | shuf -n 1)
# new_wallpaper="file://$dir/$random_file"
random_file=$(find "$dir" -maxdepth 1 -name '*.jpg' | shuf -n 1)
new_wallpaper="file://$random_file"

# set the new image as lockscreen background
gsettings set org.gnome.desktop.screensaver picture-uri "$new_wallpaper"

# lock the session like super+l would do
loginctl lock-session "$XDG_SESSION_ID"
