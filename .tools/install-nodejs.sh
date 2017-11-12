#!/bin/sh

echo "Setup nodejs (run as root to install packages, run as user to configure)"

if [ "$(id -u)" = 0 ]; then

	echo "Adding nodejs repo"
	curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
	echo "Installing nodejs and npm"
	apt install nodejs

else

	echo "Configuring npm"
	echo '> npm config set prefix ~/.local/share/npm'
	npm config set prefix ~/.local/share/npm

fi
