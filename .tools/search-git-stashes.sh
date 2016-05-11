#!/bin/sh

if [ -z $1 ]; then
	echo "Usage: $(basename $0) <keyword>"
	exit 1
fi

stash=`git fsck --no-reflog | awk '/dangling commit/ {print $3}'`

for i in ${stash[@]}; do
	match=`git show $i | grep "$1"`
	if [ "$match" != "" ]; then
		echo "\033[00;34m$i\033[00m"
		echo $match
		echo "…"
	fi
done
