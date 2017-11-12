#!/bin/sh

echo "Setup sublime package dependencies (run as root and user to completely install)"

# nodejs is required by tern_for_sublime, CSScomb
. install-nodejs.sh

if [ "$(id -u)" = 0 ]; then

	# required by Sublime​Linter-shellcheck
	apt install shellcheck

else

	# required by SublimeCodeIntel
	pip install --upgrade --pre CodeIntel

fi
