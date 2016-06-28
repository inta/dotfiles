#!/bin/bash

# check which casks are out of date and update those with force install

caskroomPath="/usr/local/Caskroom"
colorRed="\033[0;31m"
colorGreen="\033[0;32m"
colorYellow="\033[0;33m"
colorReset="\033[0m"

for app in $(brew cask list); do
	latestVersion=$(brew cask info "$app" | grep -m 1 "${app}: [^ ]*" | awk '{print $2}')
	currentVersion=$(brew cask info "$app" | grep -m 1 "$caskroomPath" | awk '{print $1}' | awk -F / '{print $6}')
	oldVersion=""
	status=""

	forceLatest=""
	if [ "$1" = "--force-latest" ] && [ "$latestVersion" = "latest" ] && [ "$currentVersion" = "latest" ]; then
		forceLatest="true"
	fi

	if [ -z "$currentVersion" ] || [ "$forceLatest" = "true" ]; then
		installedVersions=($(ls "${caskroomPath}/${app}/"))
		currentVersion=$(echo "${installedVersions[@]}" | sed -e s/\ /,\ /g)

		brew cask install --force "${app}"

		for i in "${installedVersions[@]}"; do
			rm -rf "${caskroomPath:?}/${app}/$i"
		done

		status=" ->$colorYellow Upgrade done$colorReset"
	fi

	if [ "$currentVersion" != "$latestVersion" ]; then
		oldVersion="$colorRed$currentVersion$colorReset -> "
	fi

	printf "%b" "$app: $oldVersion$colorGreen$latestVersion$colorReset$status\n"
done

brew cask cleanup
