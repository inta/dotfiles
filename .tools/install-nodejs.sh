#!/bin/sh

echo "Setup nodejs (run as root to install packages, run as user to configure)"

if [ "$(id -u)" = 0 ]; then

	echo "Adding nodejs repo"
	curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
	echo "Installing nodejs and npm"
	apt install nodejs

else

	echo "Configuring npm"
	echo '> npm config set prefix ~/.npm/global-modules'
	npm config set prefix ~/.npm/global-modules

	mkdir -p ~/.npm/global-modules/bin
	mkdir -p ~/.npm/global-modules/lib

	# npm config set init.author.name "My Name"
	# npm config set init.author.email "me@example.com"
	# npm config set init.author.url "http://example.com"
	# npm config set init.license "MIT"
	npm config set init.version "0.1.0"

fi
