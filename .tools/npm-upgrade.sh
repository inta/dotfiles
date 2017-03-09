#!/bin/sh

. "$(dirname "$0")/.lib/msg.sh"

msg "%4%NPM%7%: upgrading global packages to latest version:"

npm -g update

for packageOutdated in $(npm -g outdated --parseable --depth=0); do
	packageCurrent=$(echo "$packageOutdated" | cut -d: -f2)
	packageLatest=$(echo "$packageOutdated" | cut -d: -f4)
	msg "%3%$packageCurrent %7%-> %2%$packageLatest"
	npm -g install "$packageLatest"
done
