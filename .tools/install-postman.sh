#!/bin/sh

tar_file="$HOME/Downloads/postman.tar.gz"
target_dir="$HOME/Applications/postman"

echo "Downloading Postman ..."
wget https://dl.pstmn.io/download/latest/linux64 -O "$tar_file"
if [ $? -eq 0 ]; then
	echo "Extracting ..."
else
	exit 1
fi

mkdir -p "$target_dir"
tar -xzf "$tar_file" -C "$target_dir" --strip-components=1
if [ $? -eq 0 ]; then
	rm "$tar_file"
	echo "DONE"
fi
