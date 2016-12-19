#!/bin/sh

# check which casks are out of date and update those with force install

. "$(dirname "$0")/.lib/msg.sh"

caskroomPath="/usr/local/Caskroom"

msg "%4%Cask upgrade"

for app in $(brew cask list); do
	# do not match rubbish like "(!)"
	if echo "$app" | grep -q "^[^a-z0-9-]*$"; then
		continue;
	fi

	appInfo=$(brew cask info "$app")
	latestVersion=$(echo "$appInfo" | grep -m 1 "${app}: [^ ]*" | awk '{print $2}')
	latestPath="$caskroomPath/$app/$latestVersion"

	forceLatest=""
	if [ "$1" = "--force-latest" ] && [ "$latestVersion" = "latest" ]; then
		forceLatest="true"
	fi

	msgStr="$app:"
	if [ ! -d "$latestPath" ] || [ "$forceLatest" = "true" ]; then
		installedVersions=$(ls "$caskroomPath/$app")
		msg "$msgStr %3%${installedVersions:=[unknown]} %7%-> %2%$latestVersion"

		brew cask install --force "${app}"

		for versionDir in $installedVersions; do
			if [ "$versionDir" != "$latestVersion" ]; then
				rm -rfv "${caskroomPath:?}/${app}/$versionDir"
			fi
		done

		installedVersionsMetaData=$(ls "$caskroomPath/$app/.metadata")
		for versionDir in $installedVersionsMetaData; do
			if [ "$versionDir" != "$latestVersion" ]; then
				rm -rfv "${caskroomPath:?}/${app}/.metadata/$versionDir"
			fi
		done
	else
		msg "$msgStr %2%$latestVersion"
	fi
done

brew cask cleanup
